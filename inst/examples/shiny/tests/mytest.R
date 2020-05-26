app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(textbox = "foo bar baz")
app$snapshot()
app$setInputs(textbox = "foo")
app$snapshot()
