@Traitify = new(()->

  @host = "https://api.traitify.com"
  
  @version = "v1"

  @setHost = (host) ->
    @host = host
    this

  @setPublicKey = (key) ->
    @publicKey = key
    this

  @setVersion = (version) ->
    @version = version
    this

  @ajax = (url, method, callback, params)->
    url = "#{@host}/#{@version}#{url}"


    xhr = new XMLHttpRequest()
    if "withCredentials" of xhr

      # XHR for Chrome/Firefox/Opera/Safari.
      xhr.open method, url, true
    else unless typeof XDomainRequest is "undefined"

      # XDomainRequest for IE.
      xhr = new XDomainRequest()
      xhr.open method, url
    else

      # CORS not supported.
      alert "Whoops, there was an error making the request."
      xhr = null
    xhr

    xhr.open method, url, true

    xhr.setRequestHeader "Authorization", "Basic " + btoa(@publicKey + ":x")

    xhr.setRequestHeader "Content-type", "application/json"
    xhr.setRequestHeader "Accept", "application/json"
    xhr.onload = ->
      data = JSON.parse(xhr.response)
      callback data
      return false

    xhr.send params
    xhr

    this

  @put = (url, params, callback) ->
    @ajax url, "PUT", callback, params
    this

  @get = (url, callback) ->
    @ajax url, "GET", callback, ""
    this

  @getSlides = (id, callBack)->
    @get("/assessments/#{id}/slides", (data)->
      callBack(data)
    )

    this

  @addSlide = (assessmentId, slideId, value, timeTaken, callBack)->
    @put("/assessments/#{assessmentId}/slides/#{slideId}", "{\"response\":#{value}, \"time_taken\": #{timeTaken}}", (data)->
      callBack(data)
    )

    this
    
  @getPersonalityTypes = (id, callBack)->
    @get("/assessments/#{id}/personality_types", (data)->
      callBack(data)
    )

    this

  @getPersonalityTypesTraits = (assessmentId, personalityTypeId, callBack)->
    @get("/assessments/#{assessmentId}/personality_types/#{personalityTypeId}/personality_traits", (data)->
      callBack(data)
    )

    this
    
  @ui = Object()
  @ui.setAssessmentId = (assessmentId)->
    @assessmentId = assessmentId

  this
)()