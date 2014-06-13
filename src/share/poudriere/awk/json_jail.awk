function get_value(key) {
  match($0, "\"" key "\":\"[^\"]*\"")
  key_group = substr($0, RSTART, RLENGTH)
  match(key_group, /:"[^"]*"/)
  value = substr(key_group, RSTART+2, RLENGTH-3)
  return value
}
{
  buildname = get_value("buildname")
  if (FILENAME ~ /latest\//) {
    data = "\"" buildname "\""
    buildname = "latest"
  } else {
    data = $0
  }
  print "\"" buildname "\":" data "" | "sort -n -k1,1 -t :"
}
