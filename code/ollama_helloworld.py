import requests
import json

def ollama_generate(prompt):
    response = requests.post('http://localhost:11434/api/generate', json={
        'model': 'llama3.1:8b',
        'prompt': prompt
    }, stream=True)
    
    full_response = ""
    for line in response.iter_lines():
        if line:
            json_response = json.loads(line)
            if 'response' in json_response:
                full_response += json_response['response']
            if json_response.get('done', False):
                break
    
    return full_response.strip()

# Usage example
prompt = "전세계 최강 축구팀을 제시해봐."
response = ollama_generate(prompt)
print("Prompt:", prompt)
print("Response:", response)
