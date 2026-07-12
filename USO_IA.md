# 🤖 Uso de IA en el Proyecto

Este documento detalla **cómo, cuándo y dónde** utilizamos **GitHub Copilot** durante el desarrollo de morty_app, incluyendo prompts reales, decisiones originales y casos donde rechazamos o corregimos código generado.

---

## 📊 Resumen de uso

| Fase | Herramienta |
|------|------------|
| Setup inicial (estructura, DI) | Copilot chat + autocomplete |
| Implementación de features | Copilot autocomplete + chat |
| Testing | Copilot (boilerplate de tests) |
| Documentación | Copilot (correcciones) |


---

## 🎯 Prompts concretos utilizados


### Prompt 1: Mapeo de errores con dartz Either
**Contexto**: Crear `FailureMapper` para convertir API exceptions a `Failure`.

```
Quiero eliminar el ruido en los mensajes de error que devuelve la app,
interceptalos y manda solo mensajes ya procesados para entender de una manera simple 
que ocurrio.
Toma en cuenta que 404 al hacer una busqueda debe de retornar vacio.

```

**Resultado**: ✅ Copilot generó mapper funcional.


---

### Prompt 2: Pruebas con bloc_test y mocktail
**Contexto**: Escribir test

```
Escribe un test con bloc_test que verifique:
1. GetCharactersEvent sin nombre retorna éxito con lista
2. Estado vacío cuando API devuelve 404 (no error)
3. GetCharactersEvent con debounce no dispara 100 requests

Usa mocktail para mockear CharacterRepository.
```

**Resultado**: ✅ Copilot generó estructura correcta con `blocTest<>`, `when()`, `verify()`.

**Rechazo/Corrección**:
- Algunas veces copiliot duplico los mocks que ya se centean centralizados en helpers.
- A veces modifica/forza el test a ser aceptado, en vez de ver si es el codigo el que tiene algun fallo.

---

### Prompt 3: Widget test para CharacterCard
**Contexto**: Testear interacción del widget (tap, favorito).

```
Tengo un CharacterCard que recibe:
- character: Character
- isFavorite: bool
- onTap: VoidCallback
- onFavoriteTap: VoidCallback

Escribe widget test que verifique:
1. Muestra nombre y imagen
2. onTap se ejecuta al tocar tarjeta
3. onFavoriteTap se ejecuta al tap en ícono favorito
4. Ícono cambia según isFavorite

Usa testWidgets + MaterialApp
```

**Resultado**: ✅ Copilot generó tests funcionales.


---


## 📋 Checklist: Cómo usamos IA responsablemente

✅ **Validación manual**  
- Todo código generado se revisó linea por linea  
- Ejecutamos tests antes de commit  
- Validamos `flutter analyze` sin warnings  

✅ **Entender antes de usar**  
- Si no entendemos la sugerencia, la rechazo  
- Leemos la doc oficial para confirmar  
- Preguntamos "¿por qué?" antes de confiar  


---

## 🎓 Lecciones aprendidas

1. **IA es excelente en boilerplate**

2. **Context matters**  
   - Prompts específicos > genéricos  
   - Incluir "por qué" + "restricciones" = mejores resultados  

3. **Refactorización post-IA es normal**  
   - Aceptamos que IA entrega ~80% correcto  
   - Rol humano: pulir, entender, validar  

---

## 🔧 Proceso típico de uso

```
1. Pediré a Copilot boilerplate (ej: structure, factories, tests)
   ↓
2. Copiará código base 
   ↓
3. Revisaré línea por línea:
   - ¿Compilo? flutter analyze
   - ¿Funciona? flutter test
   - ¿Tiene sentido? Code review manual
   ↓
4. Corregiré gaps:
   - Edge cases no contemplados
   - Lógica específica del dominio
```

---

## 🌟 Valor de IA en este proyecto

| Aspecto | Evidencia |
|--------|----------|
| **Velocidad** | Setup + boilerplate|
| **Calidad** | Tests + linting descubrieron problemas |
| **Aprendizaje** | Más velocidad, menos exploración/lectura |
| **Confianza** | Requiere más validación manual |
| **Mantenibilidad** | ➡️ Sin cambio | Código legible, bien documentado |

**Conclusión**: IA ↑ productividad, pero **human review is non-negotiable**.

---

**Last updated**: Julio 2026  
**Herramienta**: GitHub Copilot (Chat + Autocomplete)  
**Versión Flutter**: 3.8.1

