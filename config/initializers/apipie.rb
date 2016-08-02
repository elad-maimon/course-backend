Apipie.configure do |config|
  config.app_name                = 'TeamLeadsCourse'
  config.api_base_url['v1']      = '/api'
  config.api_base_url['v2']      = '/api/v2'
  config.default_version         = 'v1'
  config.doc_base_url            = '/docs'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/docs/**/*.rb"
  config.app_info['v1']          = <<-EOS
    = Getting Started

    ======= Welcome to BASMACH team leads course project !

    -----------------------

    This is the API spec for the project backend, we hope you'll find this documentation helpfull.

    Let's start with some general API spec and conventions

    1. All API requests and responses should be in JSON format, so you need to set these headers
      appropriately:

        Accept: application/json
        Content-Type: application/json

    2. Response status codes are according to JSON API standard. The status codes this API may
      return are:

        200: successful GET
        201: successful resource create
        204: successful resource update or delete
        401: not authenticated
        403: authenticated user has no permissions for the action
        404: resource not found
        422: unprocessable entity (data is not valid)

    3. Unprocessable entity errors (422) will return in the response body the error list per
      parameter in this formet:

        errors: {
          param_1: ['some error message', 'another error message'],
          param_2: ['yet another error message'],
        }

    === Authentication

    -----------------------

    * To create a user see docs for POST +/api/users+ request

    * Login endpoint:

        /api/login

    * Login required params are +email+ and +password+. Must be a valid email address,
      minimum 6 characters length password and email must not exist.

      Upon successful login a cookie will be returned with the response. This cookie must be
      included to every request in order to authenticate the user.

    * Logout endpoint:

        /api/logout

    === Examples

    -----------------------

    * Signup

        curl -i -X POST localhost:3000/api/users -H "Content-Type: application/json" -H "accept: application/json" -d '{"name": "Bar Inbar", "email": "bar@basmach.com", "password": "foo-bar :)" }'

        ------
        $> HTTP/1.1 201 Created
        $> {"id":6,"name":"Bar Inbar","email":"bar@basmach.com","created_at":"2016-07-30T19:39:42.543Z","posts":[],"following":[],"followers":[]}

    * Wrong request

        curl -i -X POST localhost:3000/api/login

        ---
        $> HTTP/1.1 422 Unprocessable Entity
        $> {"errors":{"email":["can't be blank"],"password":["can't be blank"]}}

    * Login

        curl -i -X POST localhost:3000/api/login -H "Content-Type: application/json" -H "accept: application/json" -d '{"email": "bar@basmach.com", "password": "foo-bar :)" }'

        ---
        $> HTTP/1.1 201 Created
        $> Set-Cookie: _team_leads_session=VTdON00zSkNibmd2....
        $> {"user_id":"16"}
  EOS

  config.app_info['v2']          = <<-EOS
    In version 2 most of the resources remained unchanged, including the aithentication scheme.

    Changes in API V2:

    * New update user action
    * User has new attribute "interests" of type array
    * User follow / unfollow were deprecated
    * Post has new attribute "tags" of type array
  EOS
end
