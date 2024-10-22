# Титлови

Титлови за српски филмови

# 

Извуци аудио у сировом формату са 16000hz

```
ffmpeg -i  ~/video.mp4 -map 0:1 -ac 1 -ar 16000 -c:a pcm_s16le audio.wav
```

Препознај текст из аудио снимка помоћу whisper.cpp
```bash
# -ml - max length in letters
# -sow - split by words
# -l hr|sr - croatian or serbian
# -mc 0 | previous tokens to remember ~ try to change for better results

time ./main -m ./whisper.cpp/models/ggml-large-v3.bin audio.wav -ml 42 -l hr  -sow -pp  -mc 0 -osrt -of titlove.srt
```

lat2cyr.py
```
import sys

# Define a mapping of Latin characters to their corresponding Cyrillic equivalents.
latin_to_cyrillic = {
    'A': 'А', 'B': 'Б', 'C': 'Ц', 'Č': 'Ч', 'Ć': 'Ћ', 'D': 'Д', 'Dž': 'Џ', 'Đ': 'Ђ',
    'E': 'Е', 'F': 'Ф', 'G': 'Г', 'H': 'Х', 'I': 'И', 'J': 'Ј', 'K': 'К', 'L': 'Л',
    'Lj': 'Љ', 'M': 'М', 'N': 'Н', 'Nj': 'Њ', 'O': 'О', 'P': 'П', 'R': 'Р', 'S': 'С',
    'Š': 'Ш', 'T': 'Т', 'U': 'У', 'V': 'В', 'Z': 'З', 'Ž': 'Ж',
    'a': 'а', 'b': 'б', 'c': 'ц', 'č': 'ч', 'ć': 'ћ', 'd': 'д', 'dž': 'џ', 'đ': 'ђ',
    'e': 'е', 'f': 'ф', 'g': 'г', 'h': 'х', 'i': 'и', 'j': 'ј', 'k': 'к', 'l': 'л',
    'lj': 'љ', 'm': 'м', 'n': 'н', 'nj': 'њ', 'o': 'о', 'p': 'п', 'r': 'р', 's': 'с',
    'š': 'ш', 't': 'т', 'u': 'у', 'v': 'в', 'z': 'з', 'ž': 'ж'
}

# Function to convert Latin text to Cyrillic.
def latin_to_cyrillic_converter(text):
    result = ""
    i = 0
    while i < len(text):
        # Check for digraphs (two-character combinations like 'nj', 'lj', 'dž')
        if i + 1 < len(text) and text[i:i+2] in latin_to_cyrillic:
            result += latin_to_cyrillic[text[i:i+2]]
            i += 2
        # Check for uppercase digraphs (e.g., 'Nj')
        elif i + 2 < len(text) and text[i:i+2].capitalize() in latin_to_cyrillic:
            result += latin_to_cyrillic[text[i:i+2].capitalize()]
            i += 2
        # Handle single character conversions
        elif text[i] in latin_to_cyrillic:
            result += latin_to_cyrillic[text[i]]
            i += 1
        else:
            # Preserve characters that are not part of the mapping (e.g., punctuation)
            result += text[i]
            i += 1
    return result

# Read from stdin
if __name__ == "__main__":
    # Read input text from standard input (stdin)
    input_text = sys.stdin.read()
    
    # Convert the text from Latin to Cyrillic
    cyrillic_text = latin_to_cyrillic_converter(input_text)
    
    # Print the converted text to standard output (stdout)
    print(cyrillic_text)
```

cyr2lat.py
```
import sys

# Define a mapping of Cyrillic characters to their corresponding Latin equivalents.
cyrillic_to_latin = {
    'А': 'A', 'Б': 'B', 'Ц': 'C', 'Ч': 'Č', 'Ћ': 'Ć', 'Д': 'D', 'Џ': 'Dž', 'Ђ': 'Đ',
    'Е': 'E', 'Ф': 'F', 'Г': 'G', 'Х': 'H', 'И': 'I', 'Ј': 'J', 'К': 'K', 'Л': 'L',
    'Љ': 'Lj', 'М': 'M', 'Н': 'N', 'Њ': 'Nj', 'О': 'O', 'П': 'P', 'Р': 'R', 'С': 'S',
    'Ш': 'Š', 'Т': 'T', 'У': 'U', 'В': 'V', 'З': 'Z', 'Ж': 'Ž',
    'а': 'a', 'б': 'b', 'ц': 'c', 'ч': 'č', 'ћ': 'ć', 'д': 'd', 'џ': 'dž', 'ђ': 'đ',
    'е': 'e', 'ф': 'f', 'г': 'g', 'х': 'h', 'и': 'i', 'ј': 'j', 'к': 'k', 'л': 'l',
    'љ': 'lj', 'м': 'm', 'н': 'n', 'њ': 'nj', 'о': 'o', 'п': 'p', 'р': 'r', 'с': 's',
    'ш': 'š', 'т': 't', 'у': 'u', 'в': 'v', 'з': 'z', 'ж': 'ž'
}

# Function to convert Cyrillic text to Latin.
def cyrillic_to_latin_converter(text):
    result = ""
    for char in text:
        # Convert each character using the mapping, or keep it unchanged if it's not in the map.
        result += cyrillic_to_latin.get(char, char)
    return result

# Read from stdin
if __name__ == "__main__":
    # Read input text from standard input (stdin)
    input_text = sys.stdin.read()

    # Convert the text from Cyrillic to Latin
    latin_text = cyrillic_to_latin_converter(input_text)

    # Print the converted text to standard output (stdout)
    print(latin_text)
```
