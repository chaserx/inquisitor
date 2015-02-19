$("#user_email").on "blur", ->
  $(this).mailcheck
    # domains: domains # optional
    # topLevelDomains: topLevelDomains # optional
    # distanceFunction: superStringDistance # optional
    suggested: (element, suggestion) ->
      address: 'test',
      domain: 'gmail.com',
      full: 'test@gmail.com'
    empty: (element) ->
      address: 'test',
      domain: 'gmail.com',
      full: 'test@gmail.com'
  return
