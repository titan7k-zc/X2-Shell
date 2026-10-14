pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    // Expose tracked notifications to other QML files.
    readonly property var notifications: server.trackedNotifications

    NotificationServer {
        id: server

        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: notification => {
            // console.log("Notification received!")
            // console.log("App:", notification.appName)
            // console.log("Title:", notification.summary)
            // console.log("Body:", notification.body)

            // // console.log("App icon:", notification.appIcon)
            // // console.log("Notification image:", notification.image)
            // console.log("Hints:", JSON.stringify(notification.hints))

            // console.log("Actions:", JSON.stringify(notification.actions))
            // console.log("Has default action:", notification.defaultAction)




            // Inspect notification urgency
            // console.log("Urgency:", notification.urgency)
            // console.log("Hints:", JSON.stringify(notification.hints))



            // console.log("Notification timeout:", notification.expireTimeout)
            // console.log("Notification tracked:", notification.tracked)



            // console.log("App:", notification.appName)
            // console.log("ID:", notification.id)
            // console.log("Message:", notification.summary, notification.body)




            // Keep this notification in the tracked model.
            notification.tracked = true                          // clearly explainned in help.txt
        }
    }

    // clear all notifications
    function clearNotifications() {
        // root.notifications.values.forEach(notification => {
        //     notification.dismiss()
        // })
        console.log("Clearing notifications...")

        const items = root.notifications.values
        const snapshot = []

        for (let i = 0; i < items.length; i++) {
            snapshot.push(items[i])
        }

        for (const notification of snapshot) {
            notification.dismiss()
        }

    }


    // action
    function activateNotification(notification) {
        for (const action of notification.actions) {
            if (action.identifier === "default") {
                action.invoke()   
                return
            }
        }

        console.log("No default action available")
    }


 
 
} 
   
 


  