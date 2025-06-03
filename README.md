
# 📊 Proyecto Diseño de Base de Datos para Cliente

## Descripción
Este repositorio contiene un proyecto completo de diseño e implementación de base de datos relacional para la aplicación **CollectMedia**, una plataforma que permite a los usuarios organizar y gestionar sus colecciones de entretenimiento digital y físico. El objetivo es desarrollar una base de datos robusta, normalizada y escalable que soporte funcionalidades sociales, seguimiento de contenido y gestión multimedia personalizada.

---

## 📑 Tabla de Contenidos

- [Requisitos](#-requisitos)  
- [Fases del Proyecto](#-fases-del-proyecto)  
  - [1. Recolección de Requisitos](#1-recolección-de-requisitos)  
  - [2. Diseño Conceptual](#2-diseño-conceptual)  
  - [3. Diseño Lógico](#3-diseño-lógico)  
  - [4. Diseño Físico](#4-diseño-físico)  
  - [5. Implementación en MySQL](#5-implementación-en-mysql)  
  - [6. Pruebas y Validación](#6-pruebas-y-validación)  
- [Estructura del Repositorio](#-estructura-del-repositorio)  
- [Instalación y Uso](#-instalación-y-uso)  
- [Contribuciones](#-contribuciones)  
- [Licencia](#-licencia)

---

## 📝 Requisitos

- **MySQL 8.0+**  
- **MySQL Workbench** (opcional)  
- **Git**  
- **Sistema operativo**: Windows, Linux o macOS  

---

## 🔄 Fases del Proyecto

### 1. Recolección de Requisitos
- Entrevistas con el cliente (CollectMedia)
- Identificación de entidades clave: usuarios, colecciones, medios, plataformas, opiniones
- Requisitos funcionales:
  - Gestión de usuarios y sesiones
  - Seguimiento de series y anime
  - Clasificación multimedia (películas, libros, videojuegos, etc.)
  - Registro de fechas y opiniones
  - Funcionalidades sociales

---

### 2. Diseño Conceptual
- Diagrama Entidad-Relación (ER)
- Relaciones principales: 
  - Usuarios ↔ Colecciones
  - Colecciones ↔ Media
  - Media ↔ Especializaciones (película, videojuego, etc.)

---

### 3. Diseño Lógico
- Transformación del modelo ER a modelo relacional
- Relaciones N:M resueltas con tablas intermedias
- Especializaciones implementadas como 1:1
- Normalización aplicada hasta 3FN o BCNF

---

### 4. Diseño Físico
- Tipos de datos específicos para MySQL
- Índices, claves foráneas
- Separación de entidades complejas en tablas específicas (e.g., episodios, géneros)

---

### 5. Implementación en MySQL
- Scripts DDL para crear estructura
- Scripts DML para poblar datos de prueba
- Scripts para funciones, procedimientos y triggers

---

### 6. Pruebas y Validación
- Prueba de creación e inserción de datos
- Validación de restricciones y relaciones
- Consultas SQL de negocio y simulaciones
- Verificación de resultados y rendimiento

---

## 🗂️ Estructura del Repositorio

```
proyecto-base-datos/
├── Memoria.pdf
├── Conversación cliente.pdf
├── Diagrama Conceptual Final.png
├── Diagrama Relacional Final.png
├── Logo.png
├── Script CollectMedia.sql
├── README.md

---

## 💻 Instalación y Uso

1. Clona este repositorio:
   ```bash
   git clone https://github.com/franciscobertolo/proyecto-base-datos.git
   cd proyecto-base-datos
   ```
2. Abre MySQL Workbench o tu cliente favorito

---

## 🤝 Contribuciones

Las contribuciones están abiertas a mejoras en el diseño, nuevas funcionalidades o integración de APIs externas como The Movie Database. Por favor, abre un *issue* o *pull request* antes de contribuir.

---

## 📄 Licencia

Este proyecto está bajo licencia MIT. Ver `LICENSE` para más detalles.
