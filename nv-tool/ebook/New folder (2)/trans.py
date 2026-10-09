from deep_translator import GoogleTranslator

input_file = "input.txt"
output_file = "output_vi.txt"

chunk_size = 4000  

def split_text(text, size):
    return [text[i:i+size] for i in range(0, len(text), size)]

print("Đang đọc file...")
with open(input_file, "r", encoding="utf-8") as f:
    text = f.read()

chunks = split_text(text, chunk_size)

translated_text = ""

print("Đang dịch...")
for i, chunk in enumerate(chunks):
    print(f"Dịch phần {i+1}/{len(chunks)}")
    translated_text += GoogleTranslator(source="en", target="vi").translate(chunk)

print("Đang lưu file...")
with open(output_file, "w", encoding="utf-8") as f:
    f.write(translated_text)

print("Hoàn thành!")