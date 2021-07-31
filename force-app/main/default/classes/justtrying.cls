global class justtrying {

	webservice String parameter { get; set; }

	public justtrying() {
		this.parameter = 'value';
	}

	webservice static String serviceName(){
		return '';
	}
}