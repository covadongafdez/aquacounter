# Bienvenido a mi proyecto DevOps de fin de ciclo ASIR!

# Descripción del proyecto

El proyecto consiste en el despliegue de aplicaciones en Kubernetes a través de un proceso de integración y despliegue continuo (con el uso de Github Actions y ArgoCD) unido a un almacenamiento de objetos externo (con [TrueNas Core](https://www.truenas.com/docs/core/) y [Minio](https://www.truenas.com/docs/scale/scaletutorials/apps/communityapps/minioapp/). También se garantiza la observabilidad a través del uso de tecnologías como [Prometheus](https://prometheus.io/docs/introduction/overview/), [Loki](https://grafana.com/docs/loki/latest/) y [Grafana](https://grafana.com/docs/grafana/latest/).
Se crea una aplicación de ejemplo "Aquacounter" para analizar después  sus trazas de Logs con [Loki](https://grafana.com/docs/loki/latest/) y mostrar una gráfica en la que se muestra el número de veces que los empleados de una empresa bebe agua.

# Esquema general del proyecto
![WhatsApp Image 2024-05-19 at 16 29 24](https://github.com/covadongafdez/aquacounter/assets/161461508/e99655d3-d279-4c33-9a3e-fac8b99b54d3)


# Tecnologías
El objetivo era poder conocer todas las herramientas del ciclo DevOps para poder desenvolverme mejor en mi incorporación al sector.
Para ello, he usado las siguientes tecnologías:
| Tecnología      | Descripción                                                    |
|-----------------|----------------------------------------------------------------|
| [Kubernetes](https://kubernetes.io/docs/setup/)      | Orquestador de contenedores para la gestión de aplicaciones.   |
| [Docker](https://docs.docker.com/)          | Plataforma para el desarrollo, envío y ejecución de aplicaciones en contenedores. |
| [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/)           | Servidor web y proxy inverso de alto rendimiento.              |
| [TrueNAS Core](https://www.truenas.com/docs/core/)    | Plataforma de almacenamiento de datos de código abierto.       |
| [Grafana](https://grafana.com/docs/grafana/latest/)         | Plataforma de análisis y visualización de métricas.            |
| [Prometheus](https://prometheus.io/docs/introduction/overview/)      | Sistema de monitoreo y alerta de código abierto.              |
| [Loki](https://grafana.com/docs/loki/latest/)            | Sistema de registros de código abierto para nubes nativas.     |
| [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/)        | Recolector de registros para Loki.                             |
| [Velero](https://velero.io/docs/v1.7/)          | Herramienta de respaldo y restauración para Kubernetes.        |
| [GitHub](https://docs.github.com/es)          | Plataforma de desarrollo colaborativo basada en la nube.       |
| [GitHub Actions](https://docs.github.com/es/actions)  | Automatización de flujos de trabajo y CI/CD.                   |
| [MetalLB](https://metallb.universe.tf/installation/)         | Controlador de equilibrio de carga de red para Kubernetes.     |


## Diagramas
### Overview
De una manera más simple, se muestra la infraestructura creada donde se alojan en Kubernetes una capa de comunicaciones, una capa de observabilidad y la parte de despliegue continuo. Fuera del Clúster, tenemos la Integración Continua con Github Actions, como se explica en el diagrama de abajo, y la parte de Backup con True Nas, donde también se relaciona con la capa de observabilidad en uno de los buckets que almacena los logs.

![todoproyecto](https://github.com/covadongafdez/aquacounter/assets/161461508/de0ee346-f5ad-4fce-8c87-56cc5e11f3ca)


### CI/CD
En el siguiente diagrama se muestra cómo funciona la parte de CI/CD con Github Actions y Argo CD dentro de la infraestructura crada en el proyecto con Kubernetes y con el despliegue de la app creada de Aquacounter para demostrar después el uso de las herramientas de observabilidad. 


![cicdbBN](https://github.com/covadongafdez/aquacounter/assets/161461508/c9406d12-dc3a-474f-b7c3-dff8432eb81f)

### Observabilidad
Para esta parte, se ha creado una app de ejemplo, Aquacounter que genere trazas de logs. Para ello, se ha creado un script que busca en el bucket de la app en TrueNas Core un fichero csv, que será el fichero que suba "la empresa" con el control de la hidratación de sus empleados, en el que aparecerá la hora y el empleado. El script se ejecuta y muestra la siguiente salida a través del Dashboard de Loki. Una vez ejecutado el script, borra el fichero del bucket para que no genere un bucle infinito. En cuanto al dashboard, se puede personalizar según lo que se quiera ver y cómo se quiera ver. Todo ello, deberá hacerse con un query para mostrar los logs formateados.
<img width="397" alt="image" src="https://github.com/covadongafdez/aquacounter/assets/161461508/9ba0ad09-62d5-4a9a-911d-acf6a776c9e2">

## Manual de instalación
Comparto una tabla en la que comparto paso a paso como se ha hecho toda la instalación del proyecto, así como una breve explicación y el enlace a los charts de helm o a la documentación necesaria.

| Paso | Explicación/Recomendación | Documentación |
|------|----------------------------|---------------|
| 1. Creación **Máquinas virtuales** | - Si se va a copiar la máquina, modificar a mano los ID, ya que también los copia y no son únicos.<br>- Deshabilitar servicios de firewall que puedan dar problemas a Kubernetes.<br>- Crear claves ssh de cada máquina para conectarse | [Acronis Blog](https://www.acronis.com/es-es/blog/posts/hyper-v-authoritative-guide/)<br>[Microsoft Hyper-V](https://learn.microsoft.com/es-es/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) |
| 2. Configurar **RED** | - Establecer IP estática | |
| 3. Instalación **k0s** | - Descargar fichero del repo oficial. Y personalizar esquema yml.<br>- Crear y guardar kubeconfig para usar kubectl. | [k0sctl](https://github.com/k0sproject/k0sctl) |
| 4. Instalación **TrueNasCore** | - Instalar con la iso oficial. Tener en cuenta requisitos hardware.<br>- Realizar configuración de red.<br>- Crear Raid-1 desde la interfaz web.<br>- Instalar plugin de minio. | [TrueNas Hardware Guide](https://www.truenas.com/docs/core/gettingstarted/corehardwareguide/)<br>[How to Install TrueNas Core](https://www.truenas.com/blog/how-to-install-truenas-core/)<br>[TrueNas Minioplugin](https://www.truenas.com/docs/core/coretutorials/jailspluginsvms/plugins/minioplugin/) |
| 5. Creación de **repositorios** | - Creación de repositorios y cuenta en Github y Dockerhub. | [GitHub](https://github.com/)<br>[Docker Hub](https://hub.docker.com/) |
| 6. Instalar **MetalLB** | - Instalar a través de Helm y seguir indicaciones. | [MetalLB](https://artifacthub.io/packages/helm/bitnami/metallb) |
| 7. Instalación de **Lens** (opcional) | - Herramienta opcional que permite visualizar infraestructura kubernetes | [Lens](https://k8slens.dev/) |
| 8. Instalación **Ingress Controller** | - Instalar a través de Helm y seguir indicaciones. | [Nginx Ingress Controller](https://artifacthub.io/packages/helm/bitnami/nginx-ingress-controller)<br>[Nginx Installation](https://docs.nginx.com/nginx-ingress-controller/installation/installing-nic/installation-with-helm/) |
| 9. Instalación de **OpenEBS** | - Instalar a través de Helm y seguir indicaciones. | [OpenEBS](https://artifacthub.io/packages/helm/truecharts/openebs)<br>[OpenEBS Quickstart](https://openebs.io/docs/user-guides/quickstart) |
| 10. Instalación de **ArgoCD** | - Instalar a través de Helm y seguir indicaciones. | [ArgoCD](https://artifacthub.io/packages/helm/argo/argocd-apps) |
| 11. Crear **certificado TLS** | - Si se desea acceder bajo dominio propio, configurar TLS con cerbot. | [Certbot](https://eff-certbot.readthedocs.io/en/stable/using.html) |
| 12. Instalación stack **Observabilidad** | - Instalación Grafana y Prometheus a través de helm. | [Prometheus Community](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack) |
| 13. Instalación **Loki** | - Con Chart de Helm y añadir secret de acceso a TrueNas. | [Loki](https://artifacthub.io/packages/helm/grafana/loki) |
| 14. **APP** | - Creación de app de ejemplo, o búsqueda de app a desplegar, según se desee.<br>- Guardar en repositorio. | |
| 15. Access **Token** | - Crear personal Access token de github y añadirla a Argo para tener acceso al repositorio creado.<br>- Dar acceso a todo el repo. | |
| 16. **Github Actions** | - Crear carpeta especifica workflows en Github, añadir fichero yml.<br>- Seguir documentación para crear los steps necesarios. | [GitHub Actions](https://docs.github.com/es/actions) |
| 17. Instalación **Velero** (opcional) | - Crear carpeta, crear fichero credentials, instalar en máquina anfitrión.<br>- Instalar y desplegar en Kubernetes con comando personalizado en función de que almacenamiento de use y path. | [Velero Docs](https://velero.io/docs/v1.13/)<br>[Velero Releases](https://github.com/vmware-tanzu/velero/releases/tag/v1.13.2) |

> Datos a tener en cuenta:
>   - En el caso de recibir mucho tráfico, por ejemplo, no nos valdría el componente MetalLB ya que siempre dirigiría el tráfico a un mismo nodo, solo da una dirección IP, y se haría un cuello de botella. Por lo que, el nodo podría morir y/o tampoco daría el rendimiento que debería dar. Por ello, o se instalaría otro componente y fuera del Kubernetes, por ejemplo, a través de AWS donde tiene su propio servicio desplegado fuera del Kubernetes y se evitaría estos problemas de tráfico. 
>   - Como Kubernetes no es algo que se usa para apagar y encender, ya que se usara en clúster para que este operativo siempre, al desplegarlo en mi equipo local me ha generado errores cada vez que apagaba y encendía. Por ello, y por el funcionamiento propio de Kubernetes lo que hacia era usar Hyper-V, y en lugar de apagar las máquinas, guardaba su estado para luego cuando volviera a ponerme con el proyecto, le daba a iniciar y se levantaban los servicios. También, en lugar de levanta todas las máquinas a la vez lo que hacia era levantar primero los Master, luego TrueNas y luego los worker. Esto solo ocurre al hacerlo de manera local, en un servicio de cloud nunca habría este problema.
> -	Recordar dar permisos totales en los repositorios de github a la hora de general el personal token, así como en la creación del workflow de github actions, a través de la configuración de github general debemos darle permiso de lectura/escritura, sino no funcionaría y daría error.
> -	Es totalmente opcional la instalación del servicio de Velero, pero se recomienda tener un backup de toda la configuración de Kubernetes como plan de recuperación de desastres. Por ello, se indica como último punto, porque no es obligatorio.
> - Para este proyecto se ha utilizado un dominio propio para acceder a Grafana y a Argo, de ahí el apartado de certificados TLS.

# Requerimientos Hardware
Equipo donde se desplegará las máquinas virtuales para Kubernetes y TrueNas, con las siguientes especificaciones de hardware:
- Para Kubernetes se destinará: 6 Gb de RAM y 3 vCPU para el Control Plane con 3 Master, es decir: 3 máquinas virtuales, funcionando como Master, con 1vCpu y 2Gb de RAM cada una.
o	12 Gb de RAM y 6 vCPU para los Worker Nodes con 3 nodos, es decir: 3 máquinas virtuales, funcionando como Worker Nodes, de 2 vCPU y 4GB de RAM cada una.
-	Para TrueNas se destinará 1 máquina virtual con 2 vCPU y 8 Gb de RAM.


# Requerimientos Software
-	Hyper-V: para la creación y gestión de máquinas virtuales en entornos Windows.
-	Docker: para crear las imágenes de las aplicaciones.
-	Kubernetes: permite gestionar el ecosistema de contenedores y proporcionarles recursos
necesarios.
-	Sistema Operativo Ubuntu 22.04 LTS Server, instalado en los nodos de Kubernetes.
-	Git y GitHub: por un lado para controlar las versiones del código, y por otro, como repositorio de código.
-	Argo CD: asegurará la conciliación entre el estado deseado y el estado actual de las aplicaciones que gestiona.
-	TrueNAS Core: como almacenamiento de objetos externo y asegurando la persistencia de datos.
-	MetalLB: como balanceador de carga para asegurar un reparto de las solicitudes eficiente y confiable entre los nodos del clúster.
-	NGINX Ingress Controller: permite el acceso externo a la aplicación implementada en Kubernetes. Servirá también los certificados SSL para permitir acceso HTTPS.
-	Prometheus, Loki y Grafana: permiten la monitorización del rendimiento y la salud de las aplicaciones desplegadas en Kubernetes.

# Objetivos del proyecto
- Implementar un flujo de integración continua (CI) mediante GitHub Actions construyendo y subiendo la imagen al repositorio registry de Docker Hub.
-	Asegurar el despliegue continuo (CD) con Argo CD de la aplicación ejecutada en Kubernetes, comprobando los manifiestos almacenados en un repositorio de código de GitHub y cotejando las diferencias con el estado actual.
-	Utilizar una solución de observabilidad con Prometheus, Loki y Grafana para facilitar el entendimiento a la hora de monitorizar el rendimiento de los procesos desplegados en
Kubernetes.
-	Proporcionar almacenamiento persistente y escalable con TrueNAS para su consumo por las aplicaciones desplegadas.
-	Configurar NGINX Ingress Controller para que un usuario pueda acceder a la aplicación ejecutada en Kubernetes con un acceso externo desde un dominio personalizado, gestionando el cifrado de la conexión mediante el uso de certificados SSL.
-	Evaluar la eficacia y eficiencia del proceso de CI/CD implementado, gracias a las soluciones de observabilidad.


