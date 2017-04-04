module ErrorFormatter
  def self.call message, _backtrac, _option, env
    {
      Settings.meta => {
        Settings.string_success => Settings.error,
        Settings.status_code => message[Settings.status_code.to_sym] || env["api.endpoint"].status,
        Settings.message => message[Settings.content.to_sym]
      }
    }
  end
end
