//
//  TimetableWidgetLiveActivity.swift
//  TimetableWidget
//
//  Created by 한지석 on 1/2/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimetableWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TimetableWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimetableWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TimetableWidgetAttributes {
    fileprivate static var preview: TimetableWidgetAttributes {
        TimetableWidgetAttributes(name: "World")
    }
}

extension TimetableWidgetAttributes.ContentState {
    fileprivate static var smiley: TimetableWidgetAttributes.ContentState {
        TimetableWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TimetableWidgetAttributes.ContentState {
         TimetableWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TimetableWidgetAttributes.preview) {
   TimetableWidgetLiveActivity()
} contentStates: {
    TimetableWidgetAttributes.ContentState.smiley
    TimetableWidgetAttributes.ContentState.starEyes
}
