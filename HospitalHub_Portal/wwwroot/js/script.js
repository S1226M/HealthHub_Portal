// DOM Elements
const loadingScreen = document.getElementById("loading-screen")
const mainContainer = document.getElementById("main-container")
const mobileMenuBtn = document.getElementById("mobile-menu-btn")
const sidebar = document.getElementById("sidebar")
const sidebarOverlay = document.getElementById("sidebar-overlay")
const closeSidebarBtn = document.getElementById("close-sidebar")

// Loading Screen
window.addEventListener("load", () => {
    setTimeout(() => {
        loadingScreen.style.opacity = "0"
        setTimeout(() => {
            loadingScreen.style.display = "none"
            mainContainer.classList.remove("hidden")
        }, 500)
    }, 500)
})

// Force hide loading screen if it gets stuck
setTimeout(() => {
    const loadingScreen = document.getElementById("loading-screen")
    const mainContainer = document.getElementById("main-container")

    if (loadingScreen && loadingScreen.style.display !== "none") {
        loadingScreen.style.display = "none"
        mainContainer.classList.remove("hidden")
        console.log("Loading screen force hidden")
    }
}, 2000) // Force hide after 2 seconds maximum

// Mobile Menu Toggle
mobileMenuBtn.addEventListener("click", () => {
    sidebar.classList.add("open")
    sidebarOverlay.classList.add("active")
    document.body.style.overflow = "hidden"
})

// Close Sidebar
closeSidebarBtn.addEventListener("click", closeSidebar)
sidebarOverlay.addEventListener("click", closeSidebar)

function closeSidebar() {
    sidebar.classList.remove("open")
    sidebarOverlay.classList.remove("active")
    document.body.style.overflow = "auto"
}

// Responsive sidebar handling
window.addEventListener("resize", () => {
    if (window.innerWidth > 1024) {
        sidebar.classList.remove("open")
        sidebarOverlay.classList.remove("active")
        document.body.style.overflow = "auto"
    }
})

// Add hover effects to interactive elements
document.addEventListener("DOMContentLoaded", () => {
    const interactiveElements = document.querySelectorAll(".stat-card, .card, .nav-item, .action-btn")

    interactiveElements.forEach((element) => {
        element.addEventListener("mouseenter", () => {
            element.style.transform = "translateY(-2px) scale(1.02)"
        })

        element.addEventListener("mouseleave", () => {
            element.style.transform = "translateY(0) scale(1)"
        })
    })
})

// Simulate real-time updates
setInterval(() => {
    const notificationBadge = document.querySelector(".notification-badge")
    if (notificationBadge) {
        const currentCount = parseInt(notificationBadge.textContent)
        if (Math.random() > 0.8) {
            // 20% chance to update
            notificationBadge.textContent = currentCount + 1
            notificationBadge.style.animation = "bounce 0.5s ease-out"
            setTimeout(() => {
                notificationBadge.style.animation = "bounce 2s infinite"
            }, 500)
        }
    }
}, 30000) // Check every 30 seconds

// Add click effects to buttons
document.addEventListener("click", (e) => {
    if (e.target.matches("button") || e.target.closest("button")) {
        const button = e.target.matches("button") ? e.target : e.target.closest("button")
        button.style.transform = "scale(0.95)"
        setTimeout(() => {
            button.style.transform = ""
        }, 150)
    }
})

// Initialize tooltips for icons
document.addEventListener("DOMContentLoaded", () => {
    const icons = document.querySelectorAll(".stat-icon i, .card-title i")
    icons.forEach((icon) => {
        icon.addEventListener("mouseenter", () => {
            icon.style.transform = "rotate(10deg) scale(1.1)"
        })

        icon.addEventListener("mouseleave", () => {
            icon.style.transform = "rotate(0deg) scale(1)"
        })
    })
})

// Smooth scrolling for internal links
document.addEventListener("click", (e) => {
    if (e.target.matches('a[href^="#"]')) {
        e.preventDefault()
        const target = document.querySelector(e.target.getAttribute("href"))
        if (target) {
            target.scrollIntoView({
                behavior: "smooth",
                block: "start",
            })
        }
    }
})

// Add loading states to buttons
document.addEventListener("click", (e) => {
    if (e.target.matches(".primary-btn, .secondary-btn, .action-btn")) {
        const button = e.target
        const originalText = button.innerHTML

        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...'
        button.disabled = true

        setTimeout(() => {
            button.innerHTML = originalText
            button.disabled = false
        }, 2000)
    }
})
console.log("HospitalHub Admin Portal initialized successfully!")

// User Management JavaScript
document.addEventListener("DOMContentLoaded", () => {
    // Checkbox functionality
    const selectAllCheckbox = document.querySelector(".select-all-checkbox")
    const userCheckboxes = document.querySelectorAll(".user-checkbox")
    const bulkActionsBar = document.getElementById("bulkActionsBar")
    const selectedCountSpan = document.querySelector(".selected-count")

    // Select all functionality
    selectAllCheckbox.addEventListener("change", function () {
        userCheckboxes.forEach((checkbox) => {
            checkbox.checked = this.checked
        })
        updateBulkActions()
    })

    // Individual checkbox functionality
    userCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", () => {
            updateSelectAllState()
            updateBulkActions()
        })
    })

    function updateSelectAllState() {
        const checkedBoxes = document.querySelectorAll(".user-checkbox:checked")
        selectAllCheckbox.checked = checkedBoxes.length === userCheckboxes.length
        selectAllCheckbox.indeterminate = checkedBoxes.length > 0 && checkedBoxes.length < userCheckboxes.length
    }

    function updateBulkActions() {
        const checkedBoxes = document.querySelectorAll(".user-checkbox:checked")
        const count = checkedBoxes.length

        if (count > 0) {
            bulkActionsBar.style.display = "flex"
            selectedCountSpan.textContent = `${count} user${count !== 1 ? "s" : ""} selected`
        } else {
            bulkActionsBar.style.display = "none"
        }
    }

    // Search functionality
    const searchInput = document.querySelector(".search-input")
    searchInput.addEventListener("input", function () {
        // Implement search logic here
        console.log("Searching for:", this.value)
    })

    // Filter functionality
    const roleFilter = document.getElementById("roleFilter")
    const statusFilter = document.getElementById("statusFilter")

    roleFilter.addEventListener("change", function () {
        // Implement role filter logic here
        console.log("Filter by role:", this.value)
    })

    statusFilter.addEventListener("change", function () {
        // Implement status filter logic here
        console.log("Filter by status:", this.value)
    })

    // Action button functionality
    document.querySelectorAll(".action-btn-view").forEach((btn) => {
        btn.addEventListener("click", function () {
            const row = this.closest(".user-row")
            const userId = row.querySelector(".user-checkbox").dataset.userId
            console.log("View user:", userId)
            // Implement view user logic
        })
    })

    document.querySelectorAll(".action-btn-edit").forEach((btn) => {
        btn.addEventListener("click", function () {
            const row = this.closest(".user-row")
            const userId = row.querySelector(".user-checkbox").dataset.userId
            console.log("Edit user:", userId)
            // Implement edit user logic
        })
    })

    document.querySelectorAll(".action-btn-permissions").forEach((btn) => {
        btn.addEventListener("click", function () {
            const row = this.closest(".user-row")
            const userId = row.querySelector(".user-checkbox").dataset.userId
            console.log("Manage permissions for user:", userId)
            // Implement permissions logic
        })
    })
})
