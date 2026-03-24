# Architecture Overview

The Mucke application uses a layered architecture to separate concerns, ensuring that the domain logic remains independent of external frameworks, UI mechanics, and data sources. The core logic of the app resides in \`src/lib/\`. 

The source code is organized into three primary layers:

## 1. System
This layer contains the lower-level logic and adapters for external code, packages, and data persistence. It essentially acts as the infrastructure and data layer for the app.
- **\`datasources/\`**: Interfaces and implementations for reading/writing data (e.g., local databases, file system, or APIs).
- **\`models/\`**: Data transfer objects (DTOs) used to parse or represent data specific to the system layer before mapping to domain entities.
- **\`repositories/\`**: Concrete implementations of the repository interfaces defined in the domain layer.

## 2. Domain
The domain layer represents the core business logic of the application. It is completely independent of the presentation and system layers. 
- **\`entities/\`**: Core business objects and data structures.
- **\`usecases/\`**: Application-specific business rules and operations (the "what" the app does).
- **\`repositories/\`**: Abstract interfaces/contracts for data operations (the system layer implements these).
- **\`actors/\` & \`modules/\`**: Components responsible for managing specific business logic domains or coordinating broader domain workflows.

## 3. Presentation
The presentation layer contains the graphical user interface (GUI) and state management of the application. It interacts with the domain layer to read data and trigger use cases.
- **\`pages/\`**: The main screens and views of the application.
- **\`widgets/\` & \`home_widgets/\`**: Reusable UI components and specific widget fragments.
- **\`state/\`**: State management logic combining domain use cases with UI state.
- **\`theming.dart\`, \`icons.dart\`, \`gradients.dart\`**: UI styling, typography, colors, and iconography constraints.

## Dependency Rule
The architecture follows a strict dependency rule:
- \`presentation\` depends on \`domain\`.
- \`system\` depends on \`domain\`. It has to implement the interfaces of *respositories* defined there.
- \`domain\` depends on nothing (it has no external structural dependencies).
