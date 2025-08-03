const resource = (typeof GetParentResourceName === 'function') ? GetParentResourceName() : 'TRP_Core';


window.addEventListener('message', function(event) {
    if (event.data.type === 'show') {
        document.body.style.display = 'flex';
        /*const callTypeSelect = document.getElementById('callType');
        callTypeSelect.innerHTML = '';
        event.data.callTypes.forEach(type => {
            const option = document.createElement('option');
            option.value = type;
            option.textContent = type;
            callTypeSelect.appendChild(option);*/
            const callTypeSelect = document.getElementById('callType');
            callTypeSelect.innerHTML = '';

            event.data.callTypes.forEach(groupData => {
                const optgroup = document.createElement('optgroup');
                optgroup.label = groupData.group;

                groupData.types.forEach(type => {
                    const option = document.createElement('option');
                    option.value = type;
                    option.textContent = type;
                    optgroup.appendChild(option);
                });

                callTypeSelect.appendChild(optgroup);
            });
        document.getElementById('logo').src = event.data.logo;

        document.getElementById('street').value = event.data.street || '';
        document.getElementById('crossStreet').value = event.data.crossStreet || '';
        document.getElementById('zone').value = event.data.zone || '';

    } else if (event.data.type === 'hideAndReset') {
        document.body.style.display = 'none';
        document.getElementById('callForm').reset();
    }
});

document.getElementById('submitBtn').addEventListener('click', () => {
    fetch(`https://${resource}/submit911`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            callType: document.getElementById('callType').value,
            name: document.getElementById('name').value,
            street: document.getElementById('street').value,
            crossStreet: document.getElementById('crossStreet').value,
            postal: document.getElementById('postal').value,
            description: document.getElementById('description').value,
            zone: document.getElementById('zone').value,
        })
    });
});

document.getElementById('closeBtn').addEventListener('click', () => {
    fetch(`https://${resource}/closeUI`, { method: 'POST' });
});