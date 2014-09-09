Traitify.ui.resultsPersonalityTraits = (Widget, options)->
  Widget.states.add("initialized")
  
  Widget.callbacks.add("Initialize")
  
  ########################
  # INITIALIZE
  ########################
  Widget.initialization.events.add("Setup Data", ->
    Widget.partials.render("Personality Traits Container").appendTo("main")
  )

  #########################
  # PARTIALS
  #########################
  Widget.partials.add("Personality Traits Container", ->
    personalityTraitsWidgetContainer = @addDiv("tfPersonalityTraits")
    @addDiv("yourTopTraits", "Your Top Traits").appendTo("tfPersonalityTraits")
    @addDiv("personalityTraits").appendTo("tfPersonalityTraits")
    for trait in @data("traits").slice(0, 10)
      trait = trait.personality_trait
      @addDiv(["personalityTraits.trait"]).appendTo("personalityTraits")
      @addDiv(["personalityTraits.trait.name"], trait.name).appendTo(["personalityTraits.trait", _i])
      @addDiv(["personalityTraits.trait.definition"], trait.definition).appendTo(["personalityTraits.trait", _i])
      
    personalityTraitsWidgetContainer
  )

  Widget