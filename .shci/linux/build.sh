function BUILD {
	mkdir linux
	cd linux
	cmake .. -DSH_TEMPLATE_BUILD_SAMPLE=ON
	cmake --build .
}

BUILD > .shci/linux/build-output.txt
