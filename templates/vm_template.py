"""A Python template for a Compute Engine VM instance."""

def generate_config(context):
  """Creates a Compute Engine VM instance."""

  resources = [{
      'name': context.env['name'],
      'type': 'compute.v1.instance',
      'properties': {
          'zone': context.properties['zone'],
          'machineType': f"zones/{context.properties['zone']}/machineTypes/e2-small",
          'disks': [{
              'deviceName': 'boot',
              'type': 'PERSISTENT',
              'boot': True,
              'autoDelete': True,
              'initializeParams': {
                  'sourceImage': 'projects/debian-cloud/global/images/family/debian-11'
              }
          }],
          'networkInterfaces': [{
              'network': f"$(ref.{context.properties['network']}.selfLink)",
              'subnetwork': f"$(ref.{context.properties['subnetwork']}.selfLink)",
              'accessConfigs': [{
                  'name': 'External NAT',
                  'type': 'ONE_TO_ONE_NAT'
              }]
          }]
      }
  }]
  return {'resources': resources}