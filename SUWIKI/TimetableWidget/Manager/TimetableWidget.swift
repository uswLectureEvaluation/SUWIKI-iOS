//
//  TimetableWidget.swift
//  TimetableWidget
//
//  Created by 한지석 on 1/2/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
      let entry = SimpleEntry(
        date: currentDate
      )
      let nextRefresh = Calendar.current.date(
        byAdding: .minute,
        value: 5,
        to: currentDate
      )!
      
      let timeline = Timeline(
        entries: [entry],
        policy: .after(
          nextRefresh
        )
      )
      completion(
        timeline
      )
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TimetableWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            TimetableWidgetMedium()
        default:
            Text("메일로 문의 바랍니다.")
        }
    }
}

struct TimetableWidget: Widget {
    let kind: String = "TimetableWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TimetableWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TimetableWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("오늘의 강의")
        .description("오늘 있는 강의와 이러닝을 볼 수 있어요.")
    }
}

#Preview(as: .systemSmall) {
    TimetableWidget()
} timeline: {
    SimpleEntry(date: Date())
}
