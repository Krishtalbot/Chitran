using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

[RequireComponent(typeof(ARTrackedImageManager))]
public class imageTracking : MonoBehaviour
{
    [SerializeField]
    private GameObject[] arObjectsToPlace;

    [SerializeField]
    private Vector3 scaleFactor = new Vector3(0.1f, 0.1f, 0.1f);

    private ARTrackedImageManager m_TrackedImageManager;

    private Dictionary<string, GameObject> arObjects = new Dictionary<string, GameObject>();

    void Awake()
    {
        m_TrackedImageManager = GetComponent<ARTrackedImageManager>();
    }

    void OnEnable()
    {
        m_TrackedImageManager.trackedImagesChanged += OnTrackedImagesChanged;

        // Instantiate all AR objects and add them to the dictionary
        foreach (GameObject arObject in arObjectsToPlace)
        {
            GameObject newARObject = Instantiate(arObject, Vector3.zero, Quaternion.identity);
            newARObject.name = arObject.name;
            newARObject.SetActive(false); // Initially set them to inactive
            arObjects.Add(arObject.name, newARObject);
        }
    }

    void OnDisable()
    {
        m_TrackedImageManager.trackedImagesChanged -= OnTrackedImagesChanged;
    }

    void OnTrackedImagesChanged(ARTrackedImagesChangedEventArgs eventArgs)
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
                arObject.SetActive(false);

                // Destroy the AR object and remove it from the dictionary
                Destroy(arObject);
                arObjects.Remove(imageName);
            }
        }
    }

    private void UpdateARImage(ARTrackedImage trackedImage)
    {
        string imageName = trackedImage.referenceImage.name;

        if (arObjects.ContainsKey(imageName))
        {
            GameObject arObject = arObjects[imageName];
            arObject.SetActive(trackedImage.trackingState == UnityEngine.XR.ARSubsystems.TrackingState.Tracking);

            if (trackedImage.trackingState == UnityEngine.XR.ARSubsystems.TrackingState.Tracking)
            {
                arObject.transform.position = trackedImage.transform.position;
                arObject.transform.localScale = scaleFactor;
            }
        }

        Debug.Log($"trackedImage.referenceImage.name: {imageName}");
    }
}



// using System.Collections.Generic;
// using UnityEngine;
// using UnityEngine.UI;
// using UnityEngine.XR.ARFoundation;

// [RequireComponent(typeof(ARTrackedImageManager))]
// public class imageTracking : MonoBehaviour
// {

//     // [SerializeField]
//     // private Text imageTrackedText;

//     [SerializeField]
//     private GameObject[] arObjectsToPlace;

//     [SerializeField]
//     private Vector3 scaleFactor = new Vector3(0.1f,0.1f,0.1f);

//     private ARTrackedImageManager m_TrackedImageManager;

//     private Dictionary<string, GameObject> arObjects = new Dictionary<string, GameObject>();

//     void Awake()
//     {

//         m_TrackedImageManager = GetComponent<ARTrackedImageManager>();
        
//         // setup all game objects in dictionary
//         foreach(GameObject arObject in arObjectsToPlace)
//         {
//             GameObject newARObject = Instantiate(arObject, Vector3.zero, Quaternion.identity);
//             newARObject.name = arObject.name;
//             arObjects.Add(arObject.name, newARObject);
//         }
//     }

//     void OnEnable()
//     {
//         m_TrackedImageManager.trackedImagesChanged += OnTrackedImagesChanged;
//     }

//     void OnDisable()
//     {
//         m_TrackedImageManager.trackedImagesChanged -= OnTrackedImagesChanged;
//     }

//     void OnTrackedImagesChanged(ARTrackedImagesChangedEventArgs eventArgs)
//     {
//         foreach (ARTrackedImage trackedImage in eventArgs.added)
//         {
//             UpdateARImage(trackedImage);
//         }

//         foreach (ARTrackedImage trackedImage in eventArgs.updated)
//         {
//             UpdateARImage(trackedImage);
//         }

//         foreach (ARTrackedImage trackedImage in eventArgs.removed)
//         {
//             arObjects[trackedImage.name].SetActive(false);
//         }
//     }
    

//     private void UpdateARImage(ARTrackedImage trackedImage)
//     {
//         // Display the name of the tracked image in the canvas
//         // imageTrackedText.text = trackedImage.referenceImage.name;

//         // Assign and Place Game Object
//         AssignGameObject(trackedImage.referenceImage.name, trackedImage.transform.position);

//         Debug.Log($"trackedImage.referenceImage.name: {trackedImage.referenceImage.name}");
//     }

//     void AssignGameObject(string name, Vector3 newPosition)
//     {
//         if(arObjectsToPlace != null)
//         {
//             GameObject goARObject = arObjects[name];
//             goARObject.SetActive(true);
//             goARObject.transform.position = newPosition;
//             goARObject.transform.localScale = scaleFactor;
//             foreach(GameObject go in arObjects.Values)
//             {
//                 Debug.Log($"Go in arObjects.Values: {go.name}");
//                 if(go.name != name)
//                 {
//                     go.SetActive(false);
//                 }
//             } 
//         }
//     }

// }

// using System.Collections;
// using System.Collections.Generic;
// using UnityEngine;
// using UnityEngine.XR;
// using UnityEngine.XR.ARFoundation;

// [RequireComponent(typeof(ARTrackedImageManager))]
// public class imageTracking : MonoBehaviour
// {
//     [SerializeField]
//     private GameObject[] placedPrefab;

//     private Dictionary<string, GameObject> spawnedPrefab = new Dictionary<string, GameObject>();
//     private ARTrackedImageManager trackedImageManager;

//     private void Awake()
//     {
//         trackedImageManager = FindObjectOfType<ARTrackedImageManager>();

//         foreach(GameObject prefab in placedPrefab)
//         {
//             GameObject newPrefab = Instantiate(prefab, Vector3.zero, Quaternion.identity);
//             newPrefab.name = prefab.name;
//             spawnedPrefab.Add(prefab.name, newPrefab);
//         }
//     }
//     private void OnEnable()
//     {
//         trackedImageManager.trackedImagesChanged += imageChanged;
//     }
//     private void OnDisable()
//     {
//         trackedImageManager.trackedImagesChanged -= imageChanged;
//     }
//     private void imageChanged(ARTrackedImagesChangedEventArgs eventArgs)
//     {
//         foreach(ARTrackedImage trackedImage in eventArgs.added)
//         {
//             updateImage(trackedImage);
//         }
//         foreach (ARTrackedImage trackedImage in eventArgs.updated)
//         {
//             updateImage(trackedImage);
//         }
//         foreach (ARTrackedImage trackedImage in eventArgs.removed)
//         {
//             spawnedPrefab[trackedImage.name].SetActive(false);
//         }
//     }
//     private void updateImage(ARTrackedImage trackedImage)
//     {
//         string name = trackedImage.referenceImage.name;
//         Vector3 position = trackedImage.transform.position;

//         GameObject prefab = spawnedPrefab[name];
//         prefab.transform.position = position;
//         prefab.SetActive(true);

//         foreach(GameObject go in spawnedPrefab.Values)
//         {
//             if(go.name != name)
//             {
//                 go.SetActive(false);
//             }
//         }
//     }
// }

// using System.Collections.Generic;
// using UnityEngine;
// using UnityEngine.XR.ARFoundation;

// [RequireComponent(typeof(ARTrackedImageManager))]
// public class ImageTracking : MonoBehaviour
// {
//     [SerializeField]
//     private GameObject[] arObjectsToPlace;

//     [SerializeField]
//     private Vector3 scaleFactor = new Vector3(0.1f, 0.1f, 0.1f);

//     private ARTrackedImageManager m_TrackedImageManager;

//     private Dictionary<string, GameObject> arObjects = new Dictionary<string, GameObject>();

//     void Awake()
//     {
//         m_TrackedImageManager = GetComponent<ARTrackedImageManager>();
//     }

//     void OnEnable()
//     {
//         m_TrackedImageManager.trackedImagesChanged += OnTrackedImagesChanged;

//         // Instantiate all AR objects and add them to the dictionary
//         foreach (GameObject arObject in arObjectsToPlace)
//         {
//             GameObject newARObject = Instantiate(arObject, Vector3.zero, Quaternion.identity);
//             newARObject.name = arObject.name;
//             newARObject.SetActive(false); // Initially set them to inactive
//             arObjects.Add(arObject.name, newARObject);
//         }
//     }

//     void OnDisable()
//     {
//         m_TrackedImageManager.trackedImagesChanged -= OnTrackedImagesChanged;
//     }

//     void OnTrackedImagesChanged(ARTrackedImagesChangedEventArgs eventArgs)
//     {
//         foreach (ARTrackedImage trackedImage in eventArgs.added)
//         {
//             UpdateARImage(trackedImage);
//         }

//         foreach (ARTrackedImage trackedImage in eventArgs.updated)
//         {
//             UpdateARImage(trackedImage);
//         }

//         foreach (ARTrackedImage trackedImage in eventArgs.removed)
//         {
//             string imageName = trackedImage.referenceImage.name;

//             // Disable and then destroy the AR object associated with the removed image
//             if (arObjects.ContainsKey(imageName))
//             {
//                 GameObject arObject = arObjects[imageName];
//                 arObject.SetActive(false);
//                 Destroy(arObject);
//                 arObjects.Remove(imageName);
//             }
//         }
//     }

//     private void UpdateARImage(ARTrackedImage trackedImage)
//     {
//         string imageName = trackedImage.referenceImage.name;

//         if (arObjects.ContainsKey(imageName))
//         {
//             GameObject arObject = arObjects[imageName];
//             arObject.SetActive(trackedImage.trackingState == UnityEngine.XR.ARSubsystems.TrackingState.Tracking);

//             if (trackedImage.trackingState == UnityEngine.XR.ARSubsystems.TrackingState.Tracking)
//             {
//                 arObject.transform.position = trackedImage.transform.position;
//                 arObject.transform.localScale = scaleFactor;
//             }
//         }

//         Debug.Log($"trackedImage.referenceImage.name: {imageName}");
//     }
// }
