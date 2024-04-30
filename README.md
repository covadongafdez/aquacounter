# Bienvenido a mi proyecto de fin de ciclo ASIR!

# Descripción del proyecto

El proyecto consiste en el despliegue de aplicaciones en Kubernetes a través de un proceso de integración y despliegue continuo (con el uso de Github Actions y ArgoCD) unido a un almacenamiento de objetos externo (con TrueNas Core y Minio). También se garantiza la observabilidad a través del uso de tecnologías como Prometheus, Loki y Grafana.
Se crea una aplicación de ejemplo "Aquacounter" para analizar después  sus trazas de Logs con Loki y mostrar una gráfica en la que se muestra el número de veces que los empleados de una empresa bebe.


# Tecnologías
El objetivo era poder conocer todas las herramientas del ciclo DevOps para poder desenvolverme mejor en mi incorporación al sector.
Para ello, he usado las siguientes tecnologías:
| Tecnología      | Descripción                                                    |
|-----------------|----------------------------------------------------------------|
| Kubernetes      | Orquestador de contenedores para la gestión de aplicaciones.   |
| Docker          | Plataforma para el desarrollo, envío y ejecución de aplicaciones en contenedores. |
| NGINX           | Servidor web y proxy inverso de alto rendimiento.              |
| TrueNAS Core    | Plataforma de almacenamiento de datos de código abierto.       |
| Grafana         | Plataforma de análisis y visualización de métricas.            |
| Prometheus      | Sistema de monitoreo y alerta de código abierto.              |
| Loki            | Sistema de registros de código abierto para nubes nativas.     |
| Promtail        | Recolector de registros para Loki.                             |
| Velero          | Herramienta de respaldo y restauración para Kubernetes.        |
| GitHub          | Plataforma de desarrollo colaborativo basada en la nube.       |
| GitHub Actions  | Automatización de flujos de trabajo y CI/CD.                   |
| MetalLB         | Controlador de equilibrio de carga de red para Kubernetes.     |


## Manual básico de instalación


