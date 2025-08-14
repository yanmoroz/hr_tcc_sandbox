# Cursor IDE Rules for HR Sandbox Project

This directory contains AI coding assistance rules and guidelines for the Flutter HR sandbox project. These rules help Cursor understand the project structure, coding standards, and domain-specific requirements.

## 📁 Rules Structure

### Core Rules
- **[flutter.md](./flutter.md)** - Flutter-specific development guidelines
- **[hr-app.md](./hr-app.md)** - HR application domain knowledge and requirements
- **[project-structure.md](./project-structure.md)** - Project organization and file structure
- **[coding-standards.md](./coding-standards.md)** - Coding standards and best practices
- **[bloc-patterns.md](./bloc-patterns.md)** - BLoC patterns and testing guidelines

## 🎯 How to Use These Rules

### For AI Assistance
These rules are automatically read by Cursor to provide context-aware suggestions and code generation. The AI will:

- Follow Flutter best practices and patterns
- Apply HR domain knowledge when generating code
- Maintain consistent project structure
- Adhere to coding standards and conventions

### For Developers
- Reference these rules when writing new code
- Use them as a guide for code reviews
- Follow the established patterns and conventions
- Update rules as the project evolves

## 🚀 Quick Reference

### Project Overview
- **Platform**: iOS and Android only (mobile-first)
- **Architecture**: Clean Architecture with Provider state management
- **Domain**: Human Resources (HR) management system
- **Focus**: Employee management, time tracking, leave management

### Key Technologies
- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: BLoC (flutter_bloc)
- **Testing**: Flutter Test + Mockito + bloc_test
- **Platform**: iOS & Android

### Common Patterns
- **Widgets**: StatelessWidget preferred, StatefulWidget when needed
- **State**: BLoC pattern with Events and States
- **Data**: Repository pattern with local/remote data sources
- **Navigation**: Named routes with GoRouter
- **Error Handling**: Custom exceptions with user-friendly messages

## 📋 Rule Categories

### 1. Flutter Development (`flutter.md`)
- Widget organization and structure
- BLoC state management patterns
- UI/UX guidelines
- Performance optimization
- Platform-specific considerations

### 2. HR Application (`hr-app.md`)
- HR domain knowledge and requirements
- Data privacy and security
- Common HR UI patterns
- Mobile-specific features
- Compliance and legal considerations

### 3. Project Structure (`project-structure.md`)
- Directory organization
- File naming conventions
- Code organization principles
- Testing structure
- Asset management

### 4. Coding Standards (`coding-standards.md`)
- Dart language standards
- Documentation requirements
- Error handling patterns
- Testing standards
- Security considerations

### 5. BLoC Patterns (`bloc-patterns.md`)
- BLoC architecture and structure
- Widget integration patterns
- Unit and widget testing with bloc_test
- Best practices and performance optimization

## 🔄 Updating Rules

When updating these rules:

1. **Keep them current** with project evolution
2. **Add new patterns** as they emerge
3. **Document decisions** and their rationale
4. **Maintain consistency** across all rule files
5. **Test changes** to ensure they improve AI assistance

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design Guidelines](https://material.io/design)
- [HR Best Practices](https://www.shrm.org/)

---

**Note**: These rules are living documents that should evolve with the project. Regular reviews and updates ensure they remain relevant and helpful for both AI assistance and human developers. 