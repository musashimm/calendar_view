module CalendarView
  class Engine < Rails::Engine
    initializer "app.helpers.calendar_view_helper" do |app|
        ActionView::Base.send :include, CalendarViewHelper
    end
  end
end
