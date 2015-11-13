metrics = {
  pr: 0,
  waffle: 0,
  sbux: 0,
  tea: 0,
  thought: 0
}

merits = {
  akshay: 0,
  alice: 0,
  emily: 0,
  jake: 0,
  john: 0,
  jake: 0,
  kevin: 0,
}

print_metrics = (msg) ->
  output = "current metrics"
  for key, val of metrics
    output += "\n#{key}: #{val}"
  msg.send output
print_merits = (msg) ->
  output = "current merits"
  for key, val of merits
    output += "\n#{key}: #{val}"
  msg.send output


module.exports = (robot) ->

  robot.hear /^(squad|team)$/i, (msg) ->
    msg.send "ROLL CALL\n:jake:\n:john:\n:akshay:\n:alice:\n:emily:\n:kev:"

  robot.hear /^metrics$/i, (msg) ->
    print_metrics(msg)
  robot.hear /^merits$/i, (msg) ->
    print_merits(msg)

  robot.hear /^(.*)\+\+$/i, (msg) ->
    key = msg.match[1].toLowerCase()
    if key of metrics
      sender = msg.message.user.name.toLowerCase()
      metrics[key] += 1
      print_metrics(msg)
    else if key of merits
      sender = msg.message.user.name.toLowerCase()
      merits[key] += 1
      print_merits(msg)
    else
      msg.send "'#{key}' not one of: #{Object.keys(metrics)}"

  robot.hear /^(.*)\-\-$/i, (msg) ->
    key = msg.match[1].toLowerCase()
    if key of metrics
      sender = msg.message.user.name.toLowerCase()
      val = metrics[key]
      if val > 0
        metrics[key] = val - 1
      print_metrics(msg)
    else if key of merits
      sender = msg.message.user.name.toLowerCase()
      merits[key] -= 1
      print_merits(msg)
    else
      msg.send "'#{key}' not one of: #{Object.keys(metrics)}"

  robot.hear /^metrics add (.*)$/i, (msg) ->
    metric = msg.match[1].toLowerCase()
    if /[a-z_]/.test msg.match[1]
      metrics[metric] = 0
      print_metrics(msg)
    else
      msg.send "could not add '#{metric}', must contain only letters and underscores"

  robot.hear /^metrics remove (.*)$/i, (msg) ->
    key = msg.match[1].toLowerCase()
    if key of metrics
      delete metrics[key]
      print_metrics(msg)
    else
      msg.send "could not remove '#{key}', does not exist"

  # help = "usage: metrics <command>"
  # help += "\n"
  # help += "\nCommands:"
  # help += "\nhelp - list metrics commands"
  #
  # mKey = 'metrics'
  #
  # get_metrics = () ->
  #   metrics = robot.brain.get(mKey)
  #   if metrics?
  #     return metrics
  #   else
  #     metrics = {}
  #     robot.brain.set mKey, metrics
  #     return metrics
  #
  # create_metric = (metric, msg) ->
  #   metrics = get_metrics()
  #   if metric of metrics
  #     msg.send "Metric #{metric} already exists!"
  #   else
  #     metrics[metric] = 0.0
  #
  # add_metric = (metric, count) ->
  #   metrics = get_metrics()
  #   val = data[metric]
  #   if val?
  #     data[metric] = val + count
  #     msg.send "#{metric}: #{data[metric]}"
  #   else
  #     msg.send "Metric #{metric} does not exist!"
  #
  # match_regex = (metric) ->
  #   pattern = /^([A-Za-z_]+(\s[A-Za-z_]+)*)$/
  #   if pattern.test(metric)
  #     return true
  #   else
  #     return false
  #
  # show_metrics = (msg) ->
  #   metrics = get_metrics()
  #   if Object.keys(metrics).length == 0
  #     msg.send "No metrics!"
  #   else
  #     msg.send "Metrics:"
  #     for key, value of metrics
  #       msg.send "#{key}: #{value}"
  #
  # robot.respond /metrics$/i, (msg) ->
  #   show_metrics(msg)
  #
  # robot.respond /metrics help$/i, (msg) ->
  #   msg.send help
  #
  # robot.respond /metrics create (.*)$/i, (msg) ->
  #   metric = msg.match[1]
  #   if match_regex(metric)
  #     create_metric(metric, msg)
  #     msg.send "Created metric #{metric}!"
  #   else
  #     msg.send "metrics add <metric>"
  #
  # robot.respond /metrics show$/i, (msg) ->
  #   show_metrics(msg)
  #
  # robot.respond /metrics add (.*)$/i, (msg) ->
  #   possibleMetric = msg.match[1]
  #   ar = possibleMetric.split " "
  #   num = ar[ar.length-1]
  #   if /^[0-9]*[.][0-9]+$/.test(num)
  #     msg.send num
  #   msg.send possibleMetric
  #   pattern = /^([A-Za-z_]+(\s[A-Za-z_]+)*)$/
  #   if pattern.test(possibleMetric)
  #     metrics = add_metric(possibleMetric, 1)
  #     msg.send possibleMetric, "#{metrics[possibleMetric]}"
  #   else
  #     msg.send "metrics add <metric>"
  #
  # robot.respond /metrics show [a-zA-Z]+(\s[a-zA-Z]+)*$/i, (msg) ->
  #   msg.send "helpSummary"
