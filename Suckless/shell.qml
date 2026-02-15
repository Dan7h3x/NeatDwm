import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io

PanelWindow {
    id: todoWindow
    width: 400
    height: 600
    //anchors.centerIn: parent
    color: "#1e1e2e"
    //radius: 15
    //focus: true // <-- CRITICAL: Give the window focus

    // Data storage
    property var tasks: []
    property string dataFile: ".config/quickshell/todo_data.json"

    // Focus management properties
    property bool inputFocused: false

    // Load tasks on startup
    Component.onCompleted: loadTasks()

    // Task data management
    function addTask(title, category, priority, dueDate) {
        var newTask = {
            id: Date.now() + Math.random(),
            title: title,
            category: category || "General",
            priority: priority || "Medium",
            dueDate: dueDate || "",
            completed: false,
            createdAt: new Date().toISOString()
        }
        tasks.push(newTask)
        saveTasks()
        return newTask
    }

    function toggleTask(id) {
        for (var i = 0; i < tasks.length; i++) {
            if (tasks[i].id === id) {
                tasks[i].completed = !tasks[i].completed
                saveTasks()
                return
            }
        }
    }

    function deleteTask(id) {
        var newTasks = []
        for (var i = 0; i < tasks.length; i++) {
            if (tasks[i].id !== id) {
                newTasks.push(tasks[i])
            }
        }
        tasks = newTasks
        saveTasks()
    }

    function saveTasks() {
        var process = Process.createObject(todoWindow, {
            command: ["bash", "-c", "echo '" + JSON.stringify(tasks) + "' > " + dataFile]
        })
        process.running = true
    }

    function loadTasks() {
        var process = Process.createObject(todoWindow, {
            command: ["bash", "-c", "cat " + dataFile + " 2>/dev/null || echo '[]'"]
        })

        var collector = StdioCollector.createObject(process, {
            onStreamFinished: function() {
                try {
                    tasks = JSON.parse(this.text || "[]")
                } catch(e) {
                    console.log("Error loading:", e)
                    tasks = []
                }
            }
        })
        process.stdout = collector
        process.running = true
    }

    // Keyboard handling
    Keys.onPressed: (event) => {
        // Ctrl+Enter adds task
        if ((event.modifiers & Qt.ControlModifier) && event.key === Qt.Key_Return) {
            if (taskInput.text.trim() !== "") {
                addTask(taskInput.text.trim(), categoryCombo.currentText,
                       priorityCombo.currentText, dueDateField.text)
                taskInput.text = ""
                taskInput.forceActiveFocus()
            }
        }
        // Escape clears focus
        else if (event.key === Qt.Key_Escape) {
            taskInput.focus = false
            dueDateField.focus = false
            searchField.focus = false
        }
        // Tab navigation
        else if (event.key === Qt.Key_Tab) {
            if (taskInput.focus) {
                dueDateField.forceActiveFocus()
            } else if (dueDateField.focus) {
                searchField.forceActiveFocus()
            } else {
                taskInput.forceActiveFocus()
            }
            event.accepted = true
        }
    }

    // Main UI
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header with progress
        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "#181825"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 15

                Text {
                    text: "✏️ Professional Todo"
                    color: "#cdd6f4"
                    font.bold: true
                    font.pixelSize: 18
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 80
                    height: 25
                    radius: 12
                    color: "#313244"

                    Text {
                        anchors.centerIn: parent
                        text: {
                            var completed = 0
                            for (var i = 0; i < tasks.length; i++) {
                                if (tasks[i].completed) completed++
                            }
                            return tasks.length > 0 ? Math.round((completed/tasks.length)*100) + "%" : "0%"
                        }
                        color: "#a6e3a1"
                        font.pixelSize: 12
                    }
                }
            }
        }

        // Input section - FIXED FOR FOCUS
        Rectangle {
            Layout.fillWidth: true
            height: 120
            color: "#313244"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15

                TextField {
                    id: taskInput
                    Layout.fillWidth: true
                    placeholderText: "Enter new task... (Ctrl+Enter to add)"
                    color: "#cdd6f4"
                    placeholderTextColor: "#6c7086"
                    focus: true // <-- Auto-focus on startup
                    selectByMouse: true

                    background: Rectangle {
                        color: focus ? "#585b70" : "#45475a" // <-- Visual feedback
                        radius: 8
                        border.width: focus ? 1 : 0
                        border.color: "#89b4fa"
                    }

                    onAccepted: {
                        if (text.trim() !== "") {
                            addTask(text.trim(), categoryCombo.currentText,
                                   priorityCombo.currentText, dueDateField.text)
                            text = ""
                        }
                    }

                    // Ensure keyboard events reach the window
                    onActiveFocusChanged: {
                        if (focus) {
                            todoWindow.forceActiveFocus()
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    ComboBox {
                        id: categoryCombo
                        Layout.preferredWidth: 120
                        model: ["Work", "Personal", "Shopping", "Health", "Learning", "General"]
                        background: Rectangle {
                            color: "#45475a"
                            radius: 6
                        }
                        contentItem: Text {
                            text: categoryCombo.currentText
                            color: "#cdd6f4"
                            leftPadding: 10
                        }
                    }

                    ComboBox {
                        id: priorityCombo
                        Layout.preferredWidth: 100
                        model: ["High", "Medium", "Low"]
                        background: Rectangle {
                            color: "#45475a"
                            radius: 6
                        }
                        contentItem: Text {
                            text: priorityCombo.currentText
                            color: "#cdd6f4"
                            leftPadding: 10
                        }
                    }

                    TextField {
                        id: dueDateField
                        Layout.fillWidth: true
                        placeholderText: "YYYY-MM-DD (Optional)"
                        color: "#cdd6f4"
                        selectByMouse: true

                        background: Rectangle {
                            color: focus ? "#585b70" : "#45475a"
                            radius: 6
                            border.width: focus ? 1 : 0
                            border.color: "#89b4fa"
                        }

                        validator: RegularExpressionValidator {
                            regularExpression: /^\d{4}-\d{2}-\d{2}$|^$/
                        }

                        onActiveFocusChanged: {
                            if (focus) {
                                todoWindow.forceActiveFocus()
                            }
                        }
                    }

                    Button {
                        text: "Add"
                        onClicked: {
                            if (taskInput.text.trim() !== "") {
                                addTask(taskInput.text.trim(), categoryCombo.currentText,
                                       priorityCombo.currentText, dueDateField.text)
                                taskInput.text = ""
                                taskInput.forceActiveFocus()
                            }
                        }

                        background: Rectangle {
                            color: "#89b4fa"
                            radius: 6
                        }

                        contentItem: Text {
                            text: "Add"
                            color: "#1e1e2e"
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true
                        }
                    }
                }
            }
        }

        // Search bar - FIXED FOR FOCUS
        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "#313244"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    placeholderText: "Search tasks..."
                    color: "#cdd6f4"
                    selectByMouse: true

                    background: Rectangle {
                        color: focus ? "#585b70" : "#45475a"
                        radius: 8
                        border.width: focus ? 1 : 0
                        border.color: "#89b4fa"
                    }

                    onTextChanged: taskList.model = filterTasks()

                    onActiveFocusChanged: {
                        if (focus) {
                            todoWindow.forceActiveFocus()
                        }
                    }
                }

                Button {
                    text: "Filter"
                    background: Rectangle {
                        color: "#585b70"
                        radius: 8
                    }
                    contentItem: Text {
                        text: "Filter"
                        color: "#cdd6f4"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    onClicked: filterMenu.open()

                    Menu {
                        id: filterMenu
                        MenuItem {
                            text: "Show All"
                            onTriggered: taskList.model = tasks
                        }
                        MenuItem {
                            text: "Active Only"
                            onTriggered: taskList.model = tasks.filter(t => !t.completed)
                        }
                        MenuItem {
                            text: "Completed Only"
                            onTriggered: taskList.model = tasks.filter(t => t.completed)
                        }
                        MenuItem {
                            text: "High Priority"
                            onTriggered: taskList.model = tasks.filter(t => t.priority === "High")
                        }
                    }
                }
            }
        }

        // Task list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: taskList
                anchors.fill: parent
                model: tasks
                spacing: 8
                clip: true

                delegate: Rectangle {
                    width: taskList.width - 20
                    height: 70
                    radius: 10
                    color: modelData.completed ? "#313244" : "#45475a"

                    Rectangle {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: 5
                        color: {
                            if (modelData.priority === "High") return "#f38ba8"
                            if (modelData.priority === "Medium") return "#fab387"
                            return "#a6e3a1"
                        }
                        radius: 2
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 12

                        Rectangle {
                            width: 24
                            height: 24
                            radius: 6
                            border.width: 2
                            border.color: "#cdd6f4"
                            color: modelData.completed ? "#89b4fa" : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: "✓"
                                color: "#1e1e2e"
                                visible: modelData.completed
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    toggleTask(modelData.id)
                                    todoWindow.forceActiveFocus() // <-- Restore focus after click
                                }
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: modelData.title
                                color: modelData.completed ? "#6c7086" : "#cdd6f4"
                                font.strikeout: modelData.completed
                                font.pixelSize: 14
                                Layout.fillWidth: true
                            }

                            RowLayout {
                                spacing: 10

                                Rectangle {
                                    height: 20
                                    radius: 10
                                    color: {
                                        if (modelData.category === "Work") return "#89b4fa"
                                        if (modelData.category === "Personal") return "#cba6f7"
                                        if (modelData.category === "Shopping") return "#f9e2af"
                                        if (modelData.category === "Health") return "#a6e3a1"
                                        if (modelData.category === "Learning") return "#fab387"
                                        return "#74c7ec"
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.category
                                        color: "#1e1e2e"
                                        font.pixelSize: 10
                                        leftPadding: 10
                                        rightPadding: 10
                                    }
                                }

                                Text {
                                    text: modelData.dueDate ? "📅 " + modelData.dueDate : ""
                                    color: {
                                        if (!modelData.dueDate) return "transparent"
                                        var today = new Date()
                                        var due = new Date(modelData.dueDate)
                                        var diff = Math.floor((due - today) / (1000 * 60 * 60 * 24))
                                        if (diff < 0) return "#f38ba8"
                                        if (diff <= 2) return "#f9e2af"
                                        return "#a6e3a1"
                                    }
                                    font.pixelSize: 11
                                }
                            }
                        }

                        Button {
                            text: "×"
                            onClicked: {
                                deleteTask(modelData.id)
                                todoWindow.forceActiveFocus() // <-- Restore focus after click
                            }
                            background: Rectangle { color: "transparent" }
                            contentItem: Text {
                                text: "×"
                                color: "#f38ba8"
                                font.pixelSize: 20
                                font.bold: true
                            }
                        }
                    }
                }
            }
        }
    }

    // Helper function for search
    function filterTasks() {
        var searchText = searchField.text.toLowerCase()
        if (searchText === "") return tasks

        var filtered = []
        for (var i = 0; i < tasks.length; i++) {
            if (tasks[i].title.toLowerCase().includes(searchText)) {
                filtered.push(tasks[i])
            }
        }
        return filtered
    }
}
