from flask import Flask, request, jsonify
from flask_cors import CORS  # Import CORS
import numpy as np
import tensorflow as tf
from PIL import Image
import io
import base64

# Load the trained model
model = tf.keras.models.load_model('SkinModelWork.h5')

# Define label mapping
label_mapping = {0: 'nv', 1: 'mel', 2: 'bkl', 3: 'bcc', 4: 'akiec', 5: 'vasc', 6: 'df'}

app = Flask(__name__)

# Enable CORS for all routes
CORS(app)

def preprocess_image(image):
    # Convert image to RGB if not already
    if image.mode != 'RGB':
        image = image.convert('RGB')
    
    # Resize the image using Pillow (Image) and convert to numpy array
    image = image.resize((28, 28))  # Resize image to (28, 28) or the expected input size for your model
    
    # Convert the resized image to a NumPy array
    image_array = np.array(image) / 255.0  # Normalize to [0, 1]
    
    # Ensure the image has 3 channels (RGB)
    if image_array.shape[-1] != 3:
        raise ValueError("Image must have 3 channels (RGB).")
    
    return image_array.reshape((1, 28, 28, 3))  # Reshape to match model input shape

@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.json:
        return jsonify({'error': 'No image provided'}), 400
    
    base64_image = request.json['image']
    
    # Decode the base64 string to image
    try:
        # Open the image from base64 string
        image_data = Image.open(io.BytesIO(base64.b64decode(base64_image)))
        image_data = preprocess_image(image_data)
    except Exception as e:
        return jsonify({'error': f'Error processing image: {str(e)}'}), 400

    # Make prediction
    predictions = model.predict(image_data)
    predicted_class = np.argmax(predictions, axis=-1)[0]
    predicted_label = label_mapping[predicted_class]
    prediction_confidence = np.max(predictions)  # Get confidence of the prediction

    return jsonify({
        'predicted_label': predicted_label,
        'confidence': float(prediction_confidence)  # Return confidence
    })

if __name__ == '__main__':
    app.run(debug=True, port=5590)  # Ensure port matches the Flutter app's server URL
