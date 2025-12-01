# 🔥 Modelo de Dados - Firebase Firestore (Proposta)

Este documento descreve a estrutura de dados proposta para migração do `pratica-musical-v4` para o Cloud Firestore.

## 📐 Visão Geral da Estrutura

O banco de dados será dividido em duas partes principais:

1.  **Conteúdo Estático (Global)**: Programas, Módulos, Exercícios (Read-heavy, Write-rarely).
2.  **Dados do Usuário**: Progresso, Histórico, Configurações (Read/Write frequente).

---

## 📚 1. Conteúdo Global (Read-Only para o App)

### Coleção: `programs`

Armazena os cursos/programas principais.

**Document ID**: `program_id` (ex: `prog_palhetada_mestre`)

```json
{
  "title": "Mestre da Palhetada Alternada",
  "description": "Curso completo de técnica...",
  "thumbnailUrl": "url_da_imagem",
  "order": 1,
  "isVisible": true,
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

### Sub-coleção: `programs/{programId}/modules`

Módulos dentro de um programa. Usar sub-coleção facilita o carregamento sob demanda (lazy loading).

**Document ID**: `module_id` (ex: `mod_01_fundamentos`)

```json
{
  "title": "Módulo 1: Fundamentos",
  "type": "theory | practice",
  "order": 1,
  // Se type == "theory"
  "theoryContents": [
    {
      "id": "aula_01",
      "title": "A Pega da Palheta",
      "videoUrl": "vimeo_id...",
      "duration": 300
    }
  ],
  // Se type == "practice"
  "schedules": [
    {
      "id": "sched_iniciante",
      "title": "Treino A",
      "description": "Foco em relaxamento",
      "exerciseIds": ["ex_01", "ex_02"] // Referência aos IDs da coleção exercises
    }
  ]
}
```

### Coleção: `exercises` (O "Bancão" de Exercícios)

Coleção raiz contendo todos os exercícios do sistema. Isso permite reutilização entre diferentes programas sem duplicação.

**Document ID**: `exercise_id` (ex: `ex_01_corda_solta`)

```json
{
  "title": "Palhetada em Corda Solta",
  "videoUrl": "assets/videos/ex01.mp4", // Ou URL de streaming
  "tabUrl": "assets/images/tabs/ex01.png",
  "settings": {
    "warmupBpm": 50,
    "warmupDuration": 120,
    "startBpmCalibration": 60
  },
  "tags": ["palhetada", "iniciante", "mecanica"],
  "difficulty": 1
}
```

---

## 👤 2. Dados do Usuário

### Coleção: `users`

Dados do perfil do usuário.

**Document ID**: `user_uid` (do Firebase Auth)

```json
{
  "email": "user@example.com",
  "displayName": "Misael",
  "photoUrl": "...",
  "subscriptionStatus": "active | free | expired",
  "createdAt": Timestamp
}
```

### Sub-coleção: `users/{userId}/progress`

Rastreia o progresso em cada item.

**Document ID**: `content_id` (pode ser `program_id`, `module_id` ou `lesson_id`)

```json
{
  "type": "program | module | lesson | exercise",
  "status": "completed | in_progress | locked",
  "lastAccessedAt": Timestamp,
  "progressPercentage": 100, // Para programas/módulos
  "completedAt": Timestamp // Se finalizado
}
```

### Sub-coleção: `users/{userId}/practice_history`

Histórico detalhado de cada sessão de treino.

**Document ID**: Auto-generated

```json
{
  "exerciseId": "ex_01_corda_solta",
  "programId": "prog_palhetada_mestre", // Contexto de onde foi praticado
  "date": Timestamp,
  "durationSeconds": 300,
  "bpm": 80,
  "accuracy": 0.95, // Se houver medição
  "notes": "Senti dificuldade na subida..."
}
```

---

## 🧠 Considerações de Arquitetura

1.  **Desnormalização**:

    - Os exercícios são referenciados por ID dentro dos `schedules`. O app deve baixar o documento do `module` e, em seguida, buscar os exercícios necessários na coleção `exercises` (ou manter um cache local sincronizado).
    - _Alternativa_: Se a performance de leitura for crítica, podemos duplicar dados básicos do exercício (título, thumbnail) dentro do array `schedules` do módulo, mantendo o detalhe pesado (vídeo, tablatura) na coleção `exercises`.

2.  **Offline First**:

    - O Firestore tem suporte nativo a cache offline. Isso casa perfeitamente com a necessidade de praticar sem internet.

3.  **Migração**:
    - Podemos criar um script simples em Node.js ou Dart para ler o atual `initial_content.json` e popular o Firestore seguindo essa estrutura.
