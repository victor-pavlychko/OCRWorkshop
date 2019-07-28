# Presentation Deck

https://raw.githubusercontent.com/victor-pavlychko/OCRWorkshop/master/OCRWorkshop.pdf

# Prerequisites

## General

The project was created for Xcode version 10.2

## If you want to train the model

To train the models you will need the following tools installed:
- Python 2.7: `brew install python2.7`
- Jupyter Notebook: `pip install jupyter`
- TensorFlow 1.12.0: `pip install tensorflow==1.12.0`
- Other dependencies: `pip install Pillow numpy keras coremltools scikit-learn np_utils`

# Using the Workshop Repository

## Running the project

Open `OCRWorkshop.xcodeproj` and run the app.

The project contains excercises and solutions in the following files:
- `FiltersLocalContrastFilter.cikernel` and `Filters/LocalContrastFilter.cikernel_final` 
- `Vision/VisionTextDetectorExcercise.swift` and `Vision/VisionTextDetectorExcerciseFinal.swift`
- `Analysis/BitmapRowAnalyzerExcercise.swift` and `Analysis/BitmapRowAnalyzerExcerciseFinal.swift` 
- `TextDetection/TextDetectorExcercise.swift` and `TextDetection/TextDetectorExcerciseFinal.swift` 
- `TextRecognition/TextRecognizerExcercise.swift` and `TextRecognition/TextRecognizerExcerciseFinal.swift` 

## Training model

Launch Jupyter Notebook from the `Train` folder, open `train.ipynb` file and run the code.

```sh
$ cd Train
$ jupyter notebook
```

# Useful Snippets

The project contains some useful code snippets not relevant to the workshop topic but still worth mentioning:
- Bitmap handling library: `Utils/BitmapBuffer` 
- Generic error library: `Utils/Errors` 

# References

- Article about building character classifiers: https://www.learnopencv.com/deep-learning-character-classification-using-synthetic-dataset/#step5
