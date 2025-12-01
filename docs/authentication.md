# 🔐 Autenticação e Usuários

Este documento descreve a arquitetura de autenticação e o gerenciamento de usuários no app Prática Musical.

## 1. Arquitetura de Autenticação

O sistema utiliza **Firebase Authentication** como provedor de identidade.

### Provedores Suportados

1.  **Google**: Login nativo via `google_sign_in`.
2.  **Facebook**: Login nativo via `flutter_facebook_auth`.
3.  **Email/Senha**: Autenticação padrão do Firebase com suporte a recuperação de senha.

### Fluxo de Login

1.  Usuário seleciona o provedor na tela de Login.
2.  App solicita credenciais ao provedor (Google/FB) ou valida email/senha.
3.  Ao obter sucesso no Firebase Auth:
    - O app verifica se o documento do usuário existe na coleção `users` do Firestore.
    - **Se não existir**: Cria um novo documento com dados básicos.
    - **Se existir**: Atualiza dados de último login (opcional).
4.  O `AuthStore` é atualizado com o usuário logado.
5.  O usuário é redirecionado para a `HomePage`.

### Recuperação de Senha

- Fluxo nativo do Firebase: O usuário insere o email, e o Firebase envia um link para redefinição.

---

## 2. Modelo de Dados do Usuário (`users`)

Cada usuário autenticado possui um documento na coleção `users` do Firestore.

**Caminho**: `users/{uid}`

```json
{
  "uid": "string (firebase_auth_uid)",
  "email": "string",
  "displayName": "string",
  "photoUrl": "string (url)",
  "authProvider": "google | facebook | password",
  "createdAt": Timestamp,
  "lastLoginAt": Timestamp,
  "termsAccepted": true,
  "termsAcceptedAt": Timestamp
}
```

> **Nota**: Senhas nunca são armazenadas no Firestore. Elas são gerenciadas exclusivamente pelo Firebase Auth.

---

## 3. Camadas da Aplicação (Clean Architecture)

### Domain

- **Entities**: `AuthUser`
- **Repositories**: `IAuthRepository`
- **UseCases**:
  - `LoginWithGoogleUseCase`
  - `LoginWithFacebookUseCase`
  - `LoginWithEmailUseCase`
  - `RegisterWithEmailUseCase`
  - `RecoverPasswordUseCase`
  - `LogoutUseCase`
  - `CheckAuthStatusUseCase`

### Data

- **DataSources**: `IFirebaseAuthDataSource` (Implementação concreta usando SDKs)
- **Repositories**: `AuthRepositoryImpl`
- **Models**: `AuthUserModel` (Mapper para/de Firebase User)

### Presentation

- **Stores**: `AuthStore` (Gerencia estado global de auth)
- **Pages**: `LoginPage`, `RegisterPage` (opcional, pode ser integrado no Login), `ForgotPasswordPage`.
- **Widgets**: Botões de Login Social, Campos de Texto validados.

---

## 4. Segurança e Regras

- **Auth Guard**: O app verifica o estado de autenticação na inicialização. Se não houver usuário, redireciona para `LoginPage`.
- **Firestore Rules**:
  - Usuários só podem ler/escrever em seus próprios documentos (`users/{userId}`).
  - Coleções públicas (como `programs`) são Read-Only para usuários autenticados.
