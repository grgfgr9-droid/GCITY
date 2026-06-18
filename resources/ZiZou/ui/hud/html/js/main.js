$(function () {
	window.addEventListener('message', function (event) {
		var data = event.data;

		if (data.action === "hideUi") {
			if (data.value === true) {
				$("#ui").hide();
			} else {
				$("#ui").show();
			}
		} else if (data.action === "fadeUi") {
			if (data.value === true) {
				$("#ui").hide(500);
			} else {
				$("#ui").show(500);
			}
		} else if (data.action === "hideComponent") {
			if (data.value === true) {
				$("#" + data.component).hide();
			} else {
				$("#" + data.component).show();
			}
		} else if (data.action === "setStatuts") {
			for (i = 0; i < data.statuts.length; i++) {
				$(".statut .container #" + data.statuts[i].name + ".state").width(data.statuts[i].value + '%');
			}
		} else if (data.action === "setInfos") {
			$.post(`http://${GetParentResourceName()}/firstactivate`)
			$.each(data.infos, function (index, value) {
				$(".info .container #" + value.name + ".state").fadeTo(500, 0, function () {
					$(".info .container #" + value.name + ".state").html(value.value);
					$(".info .container #" + value.name + ".state").fadeTo(500, 1);
				});
			});
		} else if (data.action === "displayLogo") {
			$('#logo').css('opacity', data.opacity);
			$('#container').css('background', data.background);
		}
	});

	window.addEventListener('message', function(e) {
		if (e.data.action) {
			if (e.data.action == 'showPreviewImage') {
				$('#store-containerr').css({ 'display': "block" });
				$('#store-containerr').css({ 'background': 'url("' + e.data.image + '") no-repeat center' });
				$('#store-containerr').css({ 'background-size': 'contain' });
			} else if (e.data.action == 'hidePreviewImage') {
				$('#store-containerr').css({ 'display': "none" });
			}
		}
	});

	window.addEventListener('message', function(e) {
		if (e.data.action) {
			if (e.data.action == 'Masktroll') {
				$('#store2-container').css({ 'display': "block" });
				$('#store2-container').css({ 'background': 'url("' + e.data.image + '") no-repeat center' });
				$('#store2-container').css({ 'background-size': 'contain' });
			} else if (e.data.action == 'Masktroll2') {
				$('#store2-container').css({ 'display': "none" });
			}
		}
	});
});

