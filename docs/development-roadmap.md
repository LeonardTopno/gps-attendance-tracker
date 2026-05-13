# Development Roadmap

## Recommended Delivery Order

1. Requirements document
2. Database design
3. PHP APIs
4. Test APIs using Postman
5. Flutter app
6. Admin panel
7. Reports

This order keeps the mobile app connected to real API contracts from the beginning instead of building against assumptions.

## Phase 1: Attendance MVP Scope

1. Admin login
2. Add teaching centre with latitude and longitude
3. Add teacher
4. Assign teacher to centre
5. Teacher login API
6. Teacher check-in with GPS
7. Teacher check-out with GPS
8. Student list
9. Student attendance tick/cross
10. Daily attendance report

## Phase 2: Backend Core Implementation

- Implement PHP REST structure
- Build admin authentication
- Build teacher authentication API
- Build centre, teacher, and assignment endpoints
- Build teacher attendance endpoints
- Build student attendance endpoints
- Build daily report endpoint

## Phase 3: API Validation

- Build a Postman collection for all Phase 1 endpoints
- Validate happy-path and error-path responses
- Confirm authentication flow and token usage
- Confirm GPS validation behavior for check-in and check-out
- Confirm student attendance payload format

## Phase 4: Mobile Teacher App Screens

- Build login screen
- Build home screen
- Build check in / check out screen
- Build student attendance screen
- Build attendance history screen
- Integrate GPS permissions and API calls into the relevant flows

## Phase 5: Admin Panel MVP

- Build admin authentication
- Add teaching centre management
- Add teacher management
- Add teacher assignment management
- Add daily attendance reporting view

## Phase 6: Reports and Hardening

- Improve validation and error handling
- Add reporting exports
- Add tests for API and critical business rules
- Review security controls
- Prepare deployment documentation

## Suggested Immediate Next Step

With the Phase 1 scope fixed, the next practical step is to implement:

1. The PHP API entrypoint and database connection layer
2. Admin and teacher authentication contracts
3. The first attendance endpoints backed by the schema in `database/phase1-schema.sql`
