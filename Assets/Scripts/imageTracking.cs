using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.XR.ARFoundation;

[RequireComponent(typeof(ARTrackedImageManager))]
public class ImageTracking : MonoBehaviour
{
    [SerializeField]
    private GameObject[] arObjectsToPlace;
    
    // Use Dictionary to store the instantiated AR objects.
    private Dictionary<string, GameObject> arObjects = new Dictionary<string, GameObject>();

    [SerializeField]
    private Vector3 scaleFactor = new Vector3(0.1f, 0.1f, 0.1f);

    private ARTrackedImageManager m_TrackedImageManager;

    private void Awake()
    {
        m_TrackedImageManager = GetComponent<ARTrackedImageManager>();
    }

    private void Start()
    {
        m_TrackedImageManager.trackedImagesChanged += OnTrackedImagesChanged;

        // Instantiate all AR objects and add them to the dictionary
        foreach (GameObject arObject in arObjectsToPlace)
        {
            GameObject newARObject = Instantiate(arObject, Vector3.zero, Quaternion.identity);
            newARObject.name = arObject.name;
            newARObject.SetActive(false); // Initially set them to inactive
            arObjects.Add(newARObject.name, newARObject);
        }
    }

    private void OnDestroy()
    {
        m_TrackedImageManager.trackedImagesChanged -= OnTrackedImagesChanged;
    }

    private void OnTrackedImagesChanged(ARTrackedImagesChangedEventArgs eventArgs)
    {
        foreach (ARTrackedImage trackedImage in eventArgs.added)
        {
            UpdateARImage(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.updated)
        {
            UpdateARImage(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.removed)
        {
            string imageName = trackedImage.referenceImage.name;

            // Disable the AR object associated with the removed image
            if (arObjects.ContainsKey(imageName))
            {
                GameObject arObject = arObjects[imageName];

                // Ensure the object is destroyed properly
                Destroy(arObject);
                arObjects.Remove(imageName);
            }
        }
    }

    private void UpdateARImage(ARTrackedImage trackedImage)
    {
        if (trackedImage.trackingState == TrackingState.Limited || trackedImage.trackingState == TrackingState.None)
        {
            if (arObjects.ContainsKey(trackedImage.referenceImage.name))
            {
                GameObject arObject = arObjects[trackedImage.referenceImage.name];
                arObject.SetActive(false);
            }
            return;
        }

        if (arObjects.ContainsKey(trackedImage.referenceImage.name))
        {
            GameObject arObject = arObjects[trackedImage.referenceImage.name];
            arObject.SetActive(true);
            arObject.transform.position = trackedImage.transform.position;
            arObject.transform.localScale = scaleFactor;
        }

        Debug.Log($"trackedImage.referenceImage.name: {trackedImage.referenceImage.name}");
    }
}