defmodule JewelryStore.Shared.RegexTest do
  use JewelryStore.DataCase, async: true

  alias JewelryStore.Shared.Regex, as: R

  describe "email_regex/0" do
    test "valid email" do
      assert Regex.run(R.email_regex(), "test@gmail.com")
    end

    test "invalid email" do
      refute Regex.run(R.email_regex(), "test@gmailcom")
    end
  end
end
