# 🧠 SightSense — Technical Documentation (README)

## Overview

SightSense is an **embedded AI assistive system** designed to help visually impaired users perceive their surroundings through **real-time hazard detection, distance estimation, and face recognition**, running directly on a **Raspberry Pi**.  
The project consists of three main components:

1.  **Machine Learning**
    
    -   YOLOv8 object detection model
        
    -   DeepFace-based face recognition pipeline
        
    -   Custom monocular **distance estimation model**
        
    -   All training notebooks + datasets + performance reports
        
2.  **App Development**
    
    -   Flutter mobile application
        
    -   Firebase integration
        
    -   Device communication and hazard visualization
        
3.  **Web Development**
    
    -   Public website used to promote the SightSense ecosystem
        

----------

# 🔧 Repository Architecture

```
SightSense/
│
├── Machine Learning/
│   ├── object_detection
│   ├── face_recognition
│   └── distance_model
│
├── App Development/
│   ├── lib/
│   ├── assets/
│   └── pubspec.yaml
│
└── Web Development/
    ├── index.html
    ├── styles/
    └── scripts/

```

### Folder Purposes

#### **Machine Learning**

-   Training notebook for YOLOv8
    
-   Training notebook for DeepFace embeddings
    
-   Training notebook for distance model calibration
    
-   Dataset preprocessing scripts
    
-   Evaluation metrics / logs
    
-   Exported ONNX + TensorRT models
    

#### **App Development (Flutter)**

-   BLE pairing module
    
-   Firebase sync
    
-   Real-time hazard visualization
    
-   Accessibility-friendly UI
    
-   Device state monitoring
    

#### **Web Development**

-   Landing page explaining the product
    
-   Demo media
    
-   Documentation hosting
    
-   Responsive layout
    

----------

# 🏗 System Architecture (Technical)

```
Camera → Frame Capture → Preprocessing → 
YOLOv8 Detector → Postprocessing → 
Distance Model → 
Face Recognition (DeepFace) → 
Hazard Prioritization Engine → 
TTS Audio Output → User

```

### Communication Stack

-   **BLE** for device pairing
    
-   **Firestore** for logging & asynchronous sync
    
-   (Optional) MQTT for streaming and remote monitoring
    

----------

# 🚀 Object Detection Model (YOLOv8n — Custom Trained)

### Training Summary

-   **Images:** 3,434
    
-   **Instances:** 4,360
    
-   **Epochs:** 100
    
-   **Backbone:** YOLOv8n (modified anchors)
    
-   **Optimized for Raspberry Pi** (ONNX export, FP16/INT8 versions)
    

### Data Augmentation

-   Mosaic
    
-   HSV gain
    
-   Random blur
    
-   Perspective
    
-   Motion blur
    
-   Random cropping
    
-   CLAHE
    

----------

# 📊 Final Model Performance (Per Class)


| Class           | Images | Instances | Precision | Recall | mAP50 | mAP50-95 |
|-----------------|--------|-----------|-----------|--------|-------|----------|
| **All classes** | 3434   | 4360      | 0.847     | 0.852  | 0.887 | 0.641    |
| Autorickshaws   | 3434   | 489       | 0.918     | 0.967  | 0.981 | 0.844    |
| Bench           | 3434   | 560       | 0.869     | 0.900  | 0.914 | 0.666    |
| Crosswalk       | 3434   | 258       | 0.898     | 0.860  | 0.932 | 0.720    |
| Firehydrant     | 3434   | 379       | 0.975     | 0.995  | 0.994 | 0.726    |
| Person          | 3434   | 136       | 0.689     | 0.392  | 0.507 | 0.323    |
| Barricade       | 3434   | 308       | 0.816     | 0.877  | 0.917 | 0.661    |
| Garbage Box     | 3434   | 345       | 0.885     | 0.945  | 0.964 | 0.805    |
| Pothole         | 3434   | 337       | 0.866     | 0.899  | 0.939 | 0.654    |
| Stairs          | 3434   | 321       | 0.863     | 0.788  | 0.853 | 0.625    |
| Stray Animal    | 3434   | 435       | 0.897     | 0.904  | 0.941 | 0.659    |
| Green Light     | 3434   | 223       | 0.730     | 0.826  | 0.804 | 0.448    |
| Red Light       | 3434   | 212       | 0.741     | 0.784  | 0.822 | 0.466    |
| Vehicles        | 3434   | 357       | 0.859     | 0.941  | 0.961 | 0.735    |

### Performance on Raspberry Pi

| Variant        | FPS       | Resolution | Notes                |
| -------------- | --------- | ---------- | -------------------- |
| YOLOv8n        | ~2 FPS   | 480–640px  | CPU-only             |
| YOLOv8n INT8   | 2-3 FPS  | 480px      | Slight accuracy drop |

----------

# 🧑‍🤝‍🧑 Face Recognition Module (DeepFace)

### Pipeline

1.  Face detection → Haar Cascade (lightweight)
    
2.  Alignment
    
3.  Embedding extraction → **VGG-Face**
    
4.  Cosine similarity thresholding
    
5.  Identity decision → audio output
    

### Optimizations

-   Embedding caching (`.npy` files)
    
-   Lightweight detector on Pi
    
-   Removed unnecessary postprocessing steps
    

### Pi Performance

-   220–300 ms per embedding
    
-   Threshold (tuned): **0.43**
    

----------

# 📏 Custom Distance Estimation Model (Obstacle Distance)

SightSense includes a **custom monocular distance model** that outputs the approximate distance from the user to the detected obstacle.

### Inputs:

-   Bounding box height
    
-   Bounding box class
    
-   Camera intrinsic calibration (fx, fy, cx, cy)
    
-   Object real-world dimensions (class-aware)
    

### Methods Used:

✔ Geometry-based height-to-distance projection  
✔ Empirical regression (trained on measured samples)  
✔ Class-based heuristics for improved stability

### Outputs:

-   `SAFE` (> 2.5 m)
    
-   `CAUTION` (1–2.5 m)
    
-   `IMMEDIATE HAZARD` (< 1 m)
    

### Latency:

-   **5–12 ms** per frame
    
-   Fully lightweight, runs in real time alongside YOLO
    

----------

# 🧠 Hazard Prioritization Engine

Hazard priority is calculated using:

```
priority = f(distance_score, detection_confidence, object_class, temporal_smoothing)

```

Temporal smoothing:

```
priority_t = α * current + (1 - α) * previous

```

α = 0.7

Prevents false alarms and unstable jitter.

----------

# 📱 Flutter App — Technical Notes

### Architecture
    
-   Firebase Firestore for logs + user settings
    
-   BLE for device discovery
    

### Features

-   Real-time hazard stream
    
-   Alert history
    
-   Device status
    
-   Distance and direction UI
    
-   Accessible UI for low-vision users
    

----------

# 🌐 Web Platform (Technical)

-   Static site (HTML/CSS/JS)
    
-   Lightweight, responsive layout
    
-   Hosted on Firebase Hosting
    
-   Includes documentation + promo media
    

----------

# 📈 System Benchmarks


### Pipeline Component Latency (Raspberry Pi, CPU-only)

| Component               | Latency (ms) | Hardware |
| ----------------------- | ------------:| ----------------------- |
| YOLOv8n Inference       | 140–160      | RPi4  |
| Face Embedding (DeepFace)| 100–120     | RPi4  |
| Distance Model          | 220–240  | RPi4 |
| Hazard Fusion Logic     | 8–12         | RPi4  |
| Pre/post processing (I/O, resize, nms, TTS prep) | 20–30 | RPi4  |
| **Full Pipeline**       | **~488–562** | RPi4 |
| **Effective Pipeline Rate** | **~1.8–2.05 FPS** | End-to-end |

----------

# 🔮 Future Technical Improvements

-   Switch face model to **MobileFaceNet** (10× faster)
    
-   Integrate monocular depth CNN with pruning + quantization
    
-   Move communication to MQTT for stable streaming
    
-   Add haptic feedback module
    
-   Upgrade to Jetson Orin Nano → 3× throughput
    


