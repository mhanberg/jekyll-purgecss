# frozen_string_literal: true

Jekyll::Hooks.register(:site, :post_write) do |_site|
  if Jekyll.env == "production"
    raise PurgecssNotFoundError unless File.file?("./node_modules/.bin/purgecss")

    raise PurgecssRuntimeError unless system(
      "./node_modules/.bin/purgecss --config ./purgecss.config.js --out _site/css/"
    )
  end
end

class PurgecssNotFoundError < RuntimeError; end
class PurgecssRuntimeError < RuntimeError; end
