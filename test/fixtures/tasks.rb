task "define a method 'herp_derp' that returns 'sup foo'", %{
  begin herp_derp == 'sup foo' rescue false end
}, %{
  def herp_derp
    'sup foo'
  end
}

