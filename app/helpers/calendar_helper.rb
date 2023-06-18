module CalendarHelper
  def calendar(date = Date.current, &block)
    Calendar.new(self, date, block).table
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "table-fixed w-full text-center" do
        header + week_rows
      end
    end

    def header
      content_tag :thead, class: "bg-gray-200" do
        HEADER.map { |day| content_tag :th, day, class: "px-4 py-2" }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr, class: "border-t border-gray-300" do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = ["px-4 py-2"]
      classes << "bg-green-200" if cooking_days.include?(day)
      classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end

    def cooking_days
      # Example cooking days, you can replace this with dynamic data
      [date.beginning_of_month + 2.days, date.beginning_of_month + 9.days, date.beginning_of_month + 16.days]
    end
  end
end
