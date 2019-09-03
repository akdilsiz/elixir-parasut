defmodule Parasut.UtilCase do
	use ExUnit.CaseTemplate

	using do
		quote do
			import Parasut.UtilCase
		end
	end
end