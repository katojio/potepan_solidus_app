# rubocop:disable all

# The patch is to override exisiting method below, to supress deprecation warnings.
# https://github.com/solidusio/solidus/blob/475d9db5d0291dd4aeddc58ec919988c336729bb/core/lib/spree/money.rb#L84-L92

# [DEPRECATION] `html` is deprecated - use `html_wrap` instead. Please note that `html_wrap` will wrap all parts of currency and if you use `with_currency` option, currency element class changes from `currency` to `money-currency`.
# https://github.com/RubyMoney/money/blob/a0cbe2fe289769560cd4feada42fc00d9ea1f1af/lib/money/money/formatter.rb#L230-L232

Spree::Money.class_eval do
  def to_html(options = { html_wrap: true })
    output = format
    if options[:html] || options[:html_wrap]
      # 1) prevent blank, breaking spaces
      # 2) prevent escaping of HTML character entities
      output = output.sub(" ", "&nbsp;").html_safe
    end
    output
  end
end

# rubocop:enable all
