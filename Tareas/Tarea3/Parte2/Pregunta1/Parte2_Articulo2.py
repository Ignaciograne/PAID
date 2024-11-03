import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import dct, idct
from PIL import Image

# Función para aplicar DCT a bloques de 8x8
def apply_dct(image):
    return dct(dct(image.T, norm='ortho').T, norm='ortho')

# Función para aplicar DCT inversa a bloques de 8x8
def apply_idct(image):
    return idct(idct(image.T, norm='ortho').T, norm='ortho')

# Función para aplicar SVD
def apply_svd(matrix):
    return np.linalg.svd(matrix, full_matrices=False)

# Función para reconstruir una matriz a partir de U, S, V
def reconstruct_matrix(u, s, vh):
    return np.dot(u, np.dot(np.diag(s), vh))

# Cargar la imagen original y la marca de agua usando PIL y convertir a escala de grises
original_image = Image.open('imagen.jpg').convert('L')
watermark = Image.open('marca.jpg').convert('L')

# Convertir imágenes de PIL a arrays de NumPy
original_image = np.array(original_image)
watermark = np.array(watermark)
watermark = np.resize(watermark, (32, 32))  # Asegúrate de que el tamaño sea el correcto

# Incrustación de la marca de agua
block_size = 8
alpha = 0.1  # Factor de ganancia

# Dividir en bloques y aplicar DCT
dct_blocks = np.array([
    apply_dct(original_image[i:i+block_size, j:j+block_size])
    for i in range(0, original_image.shape[0], block_size)
    for j in range(0, original_image.shape[1], block_size)
]).reshape(original_image.shape[0] // block_size, original_image.shape[1] // block_size, block_size, block_size)

# Extraer la matriz DC y aplicar SVD
dc_matrix = dct_blocks[:, :, 0, 0]
u, s, vh = apply_svd(dc_matrix)

# Modificar la matriz S con la marca de agua
s_watermarked = s + alpha * watermark.flatten()

# Reconstruir la matriz A y reemplazar en los bloques DCT
watermarked_dc_matrix = reconstruct_matrix(u, s_watermarked, vh)
dct_blocks[:, :, 0, 0] = watermarked_dc_matrix

# Aplicar DCT inversa para obtener la imagen marcada
watermarked_image = np.array([
    apply_idct(dct_blocks[i, j])
    for i in range(dct_blocks.shape[0])
    for j in range(dct_blocks.shape[1])
]).reshape(original_image.shape)

# Extracción de la marca de agua
extracted_watermark = (s_watermarked - s) / alpha

# Visualización de imágenes
fig, ax = plt.subplots(1, 3, figsize=(10, 5))
ax[0].imshow(original_image, cmap='gray')
ax[0].set_title('Imagen Original')
ax[1].imshow(watermarked_image, cmap='gray')
ax[1].set_title('Imagen con Marca de Agua')
ax[2].imshow(extracted_watermark.reshape(32, 32), cmap='gray')
ax[2].set_title('Marca de Agua Extraída')
plt.show()
