# Universities Browser App

A production-oriented iOS application that displays universities for the United Arab Emirates, caches results locally, and supports refresh propagation across screens.

## Tech Stack

- iOS 15.1+
- Swift 6
- UIKit + SwiftUI (`UIHostingController`)
- VIPER + Clean Architecture
- Swift Package Manager
- Core Data
- Async/Await

## Architecture

The application follows **Clean Architecture** with **VIPER** feature modules.

```
Presentation (VIPER)
       ↓
Domain (Use Cases)
       ↓
Repository
       ↓
Network + Persistence
```

Navigation is handled by `UINavigationController` through Router components. SwiftUI is used only for rendering while UIKit owns navigation and screen lifecycle.

## Modules

| Module | Responsibility |
|----------|---------------|
| App | Composition root, dependency injection, navigation wiring |
| DomainKit | Domain models, repository contracts, use cases |
| NetworkKit | HTTP client, endpoints, decoding, retry handling |
| PersistenceKit | Core Data stack and caching |
| CommonUI | Shared loading, error and empty state views |
| ListingFeature | Universities listing and navigation |
| DetailsFeature | University details and refresh flow |

## Data Flow

### Initial Load

```
Listing → UseCase → Repository
        → API → Cache → Store → UI
```

### Offline Fallback

```
API Failure → Cache → UI
```

### Refresh From Details

```
Details → Coordinator → Listing
        → Repository → API
        → Cache → Store
        → Listing & Details Update
```

## State Management

A shared `UniversityStore` acts as the single source of truth. Both Listing and Details presenters observe store updates, ensuring refreshed data is automatically reflected across screens.

## Testing

Unit tests cover:

- Repository caching behavior
- Network failure fallback
- Listing Presenter & Interactor
- Details Presenter
- Domain Use Cases
- Refresh propagation workflow

## Trade-offs

- Shared `UniversityStore` was introduced to synchronize multiple feature modules while keeping them loosely coupled.
- Details delegates refresh actions instead of owning networking responsibilities, preserving a single data ownership flow.
- UIKit navigation is retained to satisfy assignment requirements while SwiftUI is used for UI composition.
