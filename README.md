# 🗂️ Base de Datos de Muertes Accidentales - Documentación

Este proyecto contiene el diseño y modelo relacional de una base de datos orientada al registro, análisis y caracterización de muertes accidentales.  
El objetivo es almacenar información socio-demográfica de la víctima, las causas asociadas, y la ubicación del hecho, siguiendo principios de normalización y correcta integridad referencial.

---

## 📌 Modelo Entidad–Relación (ER)

El sistema está compuesto principalmente por las siguientes entidades:

| Entidad | Descripción |
|--------|-------------|
| **Persona_Victima** | Contiene información demográfica, identidad y grupo poblacional de la víctima. |
| **Muerte_Accidental** | Registra la información del evento de muerte y sus características. |
| **Causa_Muerte** | Representa la causa asociada a la muerte, incluyendo mecanismo y manera. |
| **Diagnostico_Topografico** | Clasifica el tipo de lesión o diagnóstico médico correspondiente. |
| **Municipio** | Contiene la identificación del municipio donde ocurrió el hecho. |
| **Departamento** | Tabla que relaciona los departamentos del país. |


## 🧱 Modelo Relacional

### Persona_Victima
| Campo | Tipo | Descripción |
|------|------|-------------|
| `ID_Victima` (PK) | INTEGER | Identificador único de la víctima |
| `Sexo` | string | Sexo biológico |
| `Identidad_de_Genero` | string | Identidad de género declarada |
| `Transgenero` | string | Si pertenece a población transgénero |
| `Orientacion_Sexual` | string | Orientación sexual |
| `Estado_civil` | string | Estado civil |
| `Escolaridad` | string | Nivel educativo |
| `Grupo_Mayor_menor` | string | Clasificación mayor/menor de edad |
| `Grupo_edad_quinquenal` | string | Grupo etario por intervalos de 5 años |
| `Grupo_edad_judicial` | string | Clasificación judicial de edad |
| `Ciclo_vida` | string | Ciclo de vida |
| `Ancesotr_racial` | string | Ascendencia racial |
| `Pertenencia_Etnica` | string | Pertenencia étnica |
| `Pertenencia_grupal` | string | Grupo poblacional |
| `Pueblo_indigena` | string | Pueblo indígena asociado |
| `Pais_de_nacimiento` | string | País de nacimiento |

---

### Causa_Muerte
| Campo | Tipo | Descripción |
|------|------|-------------|
| `ID_causa` (PK) | int | Identificador único de causa |
| `Mecanismo_casual` | string | Mecanismo de muerte |
| `Manera_de_muerte` | string | Clasificación de la manera de muerte |
| `Diagnostico_topografico` | string | Diagnóstico topográfico de la lesión |

---

### Diagnostico_Topografico
| Campo | Tipo | Descripción |
|------|------|-------------|
| `ID_diagnostico` (PK) | int | Identificador de diagnóstico |
| `Diagnostico_topografico` | string | Tipo de lesión |
| `Mecanismo_causal` | string | Forma en que ocurrió la lesión |
| `Manera_muerte` | string | Clasificación de manera de muerte |

---

### Departamento
| Campo | Tipo |
|------|------|
| `Codigo_DANE_departamento` (PK) | string |
| `Departamento` | string |

---

### Municipio
| Campo | Tipo |
|------|------|
| `Codigo_DANE_departamento` (PK, FK)` → Departamento` | string |
| `Codigo_DANE_municipio` (PK) | string |
| `Municipio` | string |

---

### Muerte_Accidental
| Campo | Tipo | Tipo de llave |
|------|------|---------------|
| `ID` (PK) | int | Identificador del caso |
| `ID_victima` (FK) → Persona_Victima | int |
| `ID_causa` (FK) → Causa_muerte | int |
| `Codigo_DANE_departamento` (FK) → Departamento | string |
| `Codigo_DANE_municipio` (FK) → Municipio | string |
| `Año_del_hecho` | string |
| `Mes_hecho` | string |
| `Dia_hecho` | string |
| `Diagnostico_lesion` | string |
| `Circunstancia_del_hecho` | string |
| `Actividad_durante_hecho` | string |
| `Escenario_del_hecho` | string |
| `Rango_hora` | string |
| `Zona_del_hecho` | string |
| `Localidad_del_hecho` | string |
| `Manera_de_muerte` | string |
| `Mecanismo_de_muerte` | string |

---

## 🔐 Integridad y Reglas

- Todas las relaciones están **normalizadas hasta 3FN**, reduciendo redundancia.
- Se asegura consistencia territorial mediante códigos DANE.
- La referencia de diagnóstico y causa de muerte está centralizada para evitar duplicación semántica.

---

## 📦 Uso Sugerido

1. Cargar primero:
   - Departamento
   - Municipio
   - Diagnóstico y Causa
2. Registrar víctimas
3. Registrar casos en **Muerte_Accidental**.