from flask import Flask, request, json
import time
import torch
import cv2
import numpy as np

app = Flask(__name__)

class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False
        self.weight = 0  

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word, weight):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True
        node.weight = weight 

    def autocomplete(self, prefix):
        node = self.root
        for char in prefix:
            if char in node.children:
                node = node.children[char]
            else:
                return []  
        return self._find_words(node, prefix)
    
    def _find_words(self, node, prefix):
        words = []
        if node.is_end_of_word:
            words.append((prefix)) 
        for char, next_node in node.children.items():
            words.extend(self._find_words(next_node, prefix + char))
        return words

def load_words_from_file(file_path):
    trie = Trie()
    with open(file_path, 'r', encoding='utf-8') as file:
        for weight, line in enumerate(file, start=1):  
            word = line.strip()
            trie.insert(word,weight)
    return trie

trie = load_words_from_file('isaret_dili.txt')

detected_letters = []
last_update_time = time.time()

class ObjectDetection:
    def __init__(self):
        self.model = self.load_model()
        self.classes = self.model.names
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
        print("\n\nDevice Used:", self.device)

    def load_model(self):
        model = torch.hub.load(
            "ultralytics/yolov5",
            "custom",
            path=r"C:\\Users\\beyza\\Downloads\\signLangDetectTurkish\\signLangDetectTurkish\\agirlik_dosyasi.pt",
        )
        return model

    def score_frame(self, frame):
        self.model.to(self.device)
        frame = [frame]
        results = self.model(frame)
        labels, cord = results.xyxyn[0][:, -1], results.xyxyn[0][:, :-1]
        return labels, cord

    def class_to_label(self, x):
        return self.classes[int(x)]

    def detect_sign_language(self, image):
        results = self.score_frame(image)
        detected_letters = [self.class_to_label(label).upper() for label in results[0] if label >= 0.5]

        return detected_letters 

object_detection = ObjectDetection()

@app.route('/process_letters', methods=['POST'])
def process_letters():
    global detected_letters, last_update_time
    image_file = request.files["image"]

    image_data = image_file.read()
    image_array = np.frombuffer(image_data, dtype=np.uint8)
    image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)

    new_letter = object_detection.detect_sign_language(image)
    if new_letter:
        print("1.Burdayız")
        detected_letters.extend(new_letter)
        last_update_time = time.time()

    if time.time() - last_update_time >= 5:
        print("2.Burdayız")
        suggestions=[' ']
        prefix = ''.join(detected_letters)
        if prefix!='':
          suggestions = trie.autocomplete(prefix)
        detected_letters.clear()  
        last_update_time = time.time()
        print("3.Burdayız")  
        return json.dumps({'detected_letters': [suggestions[0]]})
    else:
        print("4.Burdayız")
        print(detected_letters)
        print("5.Burdayız")
        return json.dumps({'detected_letters': detected_letters})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)