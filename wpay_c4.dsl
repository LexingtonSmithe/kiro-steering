workspace "WeezPay" "C4 Architecture Model for the WeezPay (Cashless/Payment) domain at Weezevent" {

    !identifiers hierarchical

    model {
        # ─────────────────────────────────────────────
        # PEOPLE
        # ─────────────────────────────────────────────
        eventOrganiser = person "Event Organiser" "Configures cashless systems, monitors transactions, manages refunds via the back-office." "Organiser"
        cashier = person "Cashier / Vendor" "Operates the POS device on-site to sell products and process payments." "Staff"
        attendee = person "Attendee" "Event participant who tops up, pays, and requests refunds via their NFC wristband or QR code." "Attendee"
        csm = person "CSM / Support" "Customer Success Manager who troubleshoots issues, duplicates events, and manages organiser accounts." "Internal"
        developer = person "Developer" "Engineers building and operating the WeezPay platform." "Internal"

        # ─────────────────────────────────────────────
        # EXTERNAL SYSTEMS
        # ─────────────────────────────────────────────
        worldline = softwareSystem "Worldline" "Card payment processing (PSP). Provides terminal registration API and payment processing." "External"
        wallee = softwareSystem "Wallee" "Alternative PSP for app-to-app card payments on Android terminals." "External"
        fiskaly = softwareSystem "Fiskaly" "Fiscal compliance / tax signing service (Austria, Portugal, Germany)." "External"
        weezeventPlatform = softwareSystem "Weezevent Platform (Menhir)" "Core ticketing & event management platform. Source of event data, organisers, and participants." "External,Legacy"
        accounts = softwareSystem "Weezevent Accounts" "OAuth2/OIDC identity provider for authentication across all Weezevent services." "External"

        # ─────────────────────────────────────────────
        # WEEZPAY SYSTEM
        # ─────────────────────────────────────────────
        weezpay = softwareSystem "WeezPay" "Cashless payment platform for live events. Handles NFC/QR payments, top-ups, refunds, product management, and financial reconciliation." {

            # ── Frontend / Client Containers ──

            blenny = container "Blenny" "Android POS application used by cashiers on-site. Handles NFC reads, product sales, payment flows, and offline operation." "Kotlin / Jetpack Compose" "Mobile"
            daphne = container "Daphne" "Back-office web application for event organisers. Configuration, monitoring, transaction management, refunds." "React / TypeScript" "WebApp"
            gadget = container "Gadget" "Public-facing widget for attendees. Top-up, balance check, refund requests." "React / TypeScript" "WebApp"
            ray = container "Ray" "Public API portal / developer documentation. Exposes WeezPay APIs to third-party integrators." "Web Application" "WebApp"

            # ── Core Backend Containers ──

            gill = container "Gill" "Core WeezPay API. Manages products, wallets, transactions, locations, participants, and orchestrates business logic." "Python / Django / DRF" "Service" {
                tags "Core"
            }
            gillWorker = container "Gill Worker" "Asynchronous task processing for Gill. Handles background jobs, data syncs, and event-driven work." "Python / Celery" "Worker"
            lyria = container "Lyria" "Finance backend and PSP aggregator. Handles payment processing, bank reconciliation, payout calculations, and fiscal compliance." "Python / Django / DRF" "Service" {
                tags "Core"
            }
            lyriaWorker = container "Lyria Worker" "Asynchronous task processing for Lyria. High-priority payment jobs, report generation, SFTP exports." "Python / Celery" "Worker"

            # ── Microservices ──

            financeEntities = container "Finance Entities" "Manages financial entity data (emitters, payout profiles, legal entities). FastAPI microservice." "Python / FastAPI" "Service"
            einvoicing = container "E-Invoicing" "Generates and collects invoices for purchases. Handles e-invoicing compliance and encryption." "Python / Microservice" "Service"
            syncFinanceEntities = container "Sync Finance Entities" "Synchronises finance entity data from the legacy Menhir platform." "Python" "Worker"

            # ── Shared Libraries (not deployed independently) ──

            # echo-django: multi-step action confirmation lib (used in Gill)
            # weezdroid: shared Android libs (used in Blenny)
            # Wallee-app-to-app: bridge between Blenny and Wallee PSP

            # ── Payment Bridge ──

            walleebridge = container "Wallee App-to-App" "Intermediate Android application bridging Blenny to the Wallee SDK for card payments." "Kotlin / Android" "Mobile"

            # ── Data Stores ──

            gillDb = container "Gill Database" "Primary data store for WeezPay business data: products, wallets, transactions, participants, locations." "PostgreSQL 18" "Database"
            lyriaDb = container "Lyria Database" "Financial data store: payment records, bank reconciliation, payout data." "PostgreSQL 18" "Database"
            financeEntitiesDb = container "Finance Entities Database" "Stores emitter, payout profile, and legal entity data." "PostgreSQL" "Database"
            gillRedis = container "Gill Cache" "Caching layer and Celery broker for Gill." "Redis" "Cache"
            lyriaRedis = container "Lyria Cache" "Caching layer and Celery broker for Lyria." "Redis" "Cache"
            gillElastic = container "Gill Search" "Full-text search index for transactions and participants." "Elasticsearch" "Database"
            gillS3 = container "Gill Object Storage" "Stores exports, reports, and media assets." "AWS S3" "Storage"

            # ── Messaging ──

            symba = container "Symba" "Internal event/message bus for async inter-service communication." "Message Broker (RabbitMQ/SQS)" "Queue"
        }

        # ─────────────────────────────────────────────
        # RELATIONSHIPS — Level 1 (System Context)
        # ─────────────────────────────────────────────

        cashier -> weezpay "Sells products, processes NFC/QR payments" "Android POS"
        eventOrganiser -> weezpay "Configures events, monitors transactions, manages refunds" "Web Browser"
        attendee -> weezpay "Tops up balance, checks balance, requests refunds" "Web Browser / NFC"
        csm -> weezpay "Troubleshoots issues, manages organiser accounts" "Web Browser"
        developer -> weezpay "Builds, deploys, and operates the platform" "IDE / CLI"

        weezpay -> worldline "Processes card payments, registers terminals" "REST API / HTTPS"
        weezpay -> wallee "Processes card payments (app-to-app)" "Android Intent / HTTPS"
        weezpay -> fiskaly "Signs fiscal receipts for compliance" "REST API / HTTPS"
        weezpay -> weezeventPlatform "Reads event data, participants, organisers; syncs entities" "REST API / HTTPS"
        weezpay -> accounts "Authenticates users via OAuth2/OIDC" "HTTPS / JWT"

        # ─────────────────────────────────────────────
        # RELATIONSHIPS — Level 2 (Container)
        # ─────────────────────────────────────────────

        # People → Containers
        cashier -> weezpay.blenny "Operates POS" "Touch UI"
        eventOrganiser -> weezpay.daphne "Configures and monitors" "Web Browser"
        attendee -> weezpay.gadget "Top-up, balance, refund" "Web Browser"
        developer -> weezpay.ray "Reads API documentation" "Web Browser"

        # Frontend → Backend
        weezpay.blenny -> weezpay.gill "Fetches products, locations, wallets; submits transactions" "REST API / HTTPS"
        weezpay.blenny -> weezpay.walleebridge "Delegates card payments" "Android Intent"
        weezpay.daphne -> weezpay.gill "CRUD operations on all WeezPay entities" "REST API / HTTPS"
        weezpay.gadget -> weezpay.gill "Top-up, balance enquiry, refund requests" "REST API / HTTPS"
        weezpay.ray -> weezpay.gill "Proxies public API requests" "REST API / HTTPS"

        # Backend internal
        weezpay.gill -> weezpay.lyria "Payment processing, financial operations, PSP delegation" "REST API / HTTPS"
        weezpay.gill -> weezpay.financeEntities "Reads/writes emitter and payout profile data" "REST API / HTTPS"
        weezpay.gill -> weezpay.einvoicing "Triggers invoice generation" "REST API / HTTPS"
        weezpay.gill -> weezpay.gillDb "Reads/writes business data" "SQL / TCP"
        weezpay.gill -> weezpay.gillRedis "Caches, queues async tasks" "Redis Protocol"
        weezpay.gill -> weezpay.gillElastic "Indexes and searches transactions" "HTTP"
        weezpay.gill -> weezpay.gillS3 "Stores/retrieves exports and media" "S3 API"
        weezpay.gillWorker -> weezpay.gillDb "Processes background jobs" "SQL / TCP"
        weezpay.gillWorker -> weezpay.gillRedis "Consumes task queue" "Redis Protocol"

        weezpay.lyria -> weezpay.lyriaDb "Reads/writes financial data" "SQL / TCP"
        weezpay.lyria -> weezpay.lyriaRedis "Caches, queues async tasks" "Redis Protocol"
        weezpay.lyria -> weezpay.symba "Publishes financial events" "AMQP / Memory"
        weezpay.lyriaWorker -> weezpay.lyriaDb "Processes async financial jobs" "SQL / TCP"
        weezpay.lyriaWorker -> weezpay.lyriaRedis "Consumes task queue" "Redis Protocol"

        weezpay.financeEntities -> weezpay.financeEntitiesDb "Persists finance entity data" "SQL / TCP"
        weezpay.syncFinanceEntities -> weezpay.financeEntities "Syncs entity data from Menhir" "REST API"
        weezpay.syncFinanceEntities -> weezeventPlatform "Reads legacy finance entities" "REST API / HTTPS"

        # External integrations from containers
        weezpay.lyria -> worldline "Payment authorisation, terminal registration" "REST API / HTTPS"
        weezpay.lyria -> fiskaly "Fiscal receipt signing" "REST API / HTTPS"
        weezpay.walleebridge -> wallee "Card payment processing" "Wallee SDK / HTTPS"
        weezpay.lyria -> accounts "Validates tokens, authenticates service" "OAuth2 / HTTPS"
        weezpay.gill -> accounts "Validates user tokens" "JWT verification"
        weezpay.gill -> weezeventPlatform "Syncs event data, participants" "REST API / HTTPS"
    }

    views {
        systemContext weezpay "SystemContext" "Level 1: System Context diagram for WeezPay" {
            include *
            autoLayout tb
        }

        container weezpay "Containers" "Level 2: Container diagram for WeezPay" {
            include *
            autoLayout tb
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Organiser" {
                background #1168bd
            }
            element "Staff" {
                background #2b8cbe
            }
            element "Attendee" {
                background #74a9cf
            }
            element "Internal" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Legacy" {
                background #666666
                shape RoundedBox
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Service" {
                shape Hexagon
            }
            element "WebApp" {
                shape WebBrowser
            }
            element "Mobile" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
                background #f5a623
                color #000000
            }
            element "Cache" {
                shape Cylinder
                background #e74c3c
                color #ffffff
            }
            element "Storage" {
                shape Folder
                background #f39c12
                color #000000
            }
            element "Queue" {
                shape Pipe
                background #9b59b6
                color #ffffff
            }
            element "Worker" {
                shape Robot
                background #2ecc71
                color #000000
            }
            element "Core" {
                background #1a5276
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}
