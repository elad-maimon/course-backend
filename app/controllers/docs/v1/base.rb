class Docs::V1::Base < ActionController::Base
  resource_description do
    api_version 'v1'
    # name 'bundles'
    # error 404, "Missing"
    # error 500, "Server crashed for some <%= reason %>", meta: {anything: "you can think of"}
  end
end
