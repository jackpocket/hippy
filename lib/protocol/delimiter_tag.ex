defmodule Hippy.Protocol.DelimiterTag do
  use Hippy.Protocol.Enum, %{
    operation_attributes: 0x01,
    job_attributes: 0x02,
    end_of_attributes: 0x03,
    printer_attributes: 0x04,
    unsupported_attributes: 0x05,
    subscription_attributes: 0x06
  }
end
