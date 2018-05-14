module AppStore
    App = Struct.new(:name, :developer, :version)

    APPS = [
        App.new("chat", "facebook", "10.12")
        App.new("Whatsapp", "facebook", "9.1")
        App.new("Go", "Google", "9.0")
    ]

    def self.find_app
        APPS.find{|app| app.name == name}
    end


end