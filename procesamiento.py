import pandas as pd
import logging
def read_and_transform_data(file_path):
    # Leer datos desde un archivo CSV
    data = pd.read_csv(file_path)
    
    # Contar las veces que cada empleado bebe agua
    water_counts = data['empleado'].value_counts()
    
    # Aquí podrías añadir los logs a Loki, usando, por ejemplo, la librería de logging
    logging.basicConfig(level=logging.INFO)
    for empleado, veces in water_counts.items():
        logging.info(f"{empleado} - {veces}")

if __name__ == "__main__":
    file_path = 'input.csv'
    read_and_transform_data(file_path)