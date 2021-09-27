defmodule Hippy.Operation.CreatePrinterSubscription do
  @moduledoc """
  Represents a request to create a printer subscription

  The printer_uri is:
  printer ipp://server/printers/printername
  class (ipp://server/classes/classname)
  or server (ipp://server/) URI for event notifications.
  """

  @def_charset "utf-8"
  @def_lang "en"
  @def_username "hippy"
  @def_notify_events "all"

  @enforce_keys [:printer_uri, :notify_recipient_url]

  defstruct printer_uri: nil,
            notify_recipient_url: nil,
            notify_events: [],
            charset: @def_charset,
            language: @def_lang,
            username: @def_username

  def new(printer_uri, notify_recipient_url, opts \\ []) do
    target = String.replace(printer_uri, ~r/^http(s)?/, "ipp")

    %__MODULE__{
      printer_uri: target,
      notify_recipient_url: notify_recipient_url,
      notify_events: Keyword.get(opts, :notify_events, @def_notify_events),
      charset: Keyword.get(opts, :charset, @def_charset),
      language: Keyword.get(opts, :language, @def_lang),
      username: Keyword.get(opts, :username, @def_username)
    }
  end
end

defimpl Hippy.Operation, for: Hippy.Operation.CreatePrinterSubscription do
  def build_request(op) do
    target = String.replace(op.printer_uri, ~r/^http(s)?/, "ipp")

    %Hippy.Request{
      request_id: System.unique_integer([:positive, :monotonic]),
      operation_id: Hippy.Protocol.Operation.create_printer_subscription(),
      operation_attributes: [
        {:charset, "attributes-charset", op.charset},
        {:natural_language, "attributes-natural-language", op.language},
        {:uri, "printer-uri", target}
      ],
      subscription_attributes: [
        {:keyword, "notify-pull-method", "ippget"},
        {:charset, "notify-charset", op.charset},
        {:name_without_language, "requesting-user-name", op.username},
        {:uri, "notify-recipient-uri", op.notify_recipient_url},
        {:keyword, "notify-events", op.notify_events}
      ],
      data: <<>>
    }
  end
end
