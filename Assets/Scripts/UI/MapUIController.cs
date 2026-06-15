using UnityEngine;
using TMPro;

/// <summary>
/// Displays map and zone information in the UI
/// </summary>
public class MapUIController : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI currentZoneText;
    [SerializeField] private TextMeshProUGUI zoneInfoText;

    private void Start()
    {
        var zoneManager = ZoneManager.Instance;
        if (zoneManager != null)
        {
            zoneManager.OnEnterZone += UpdateZoneDisplay;
        }
    }

    private void UpdateZoneDisplay(MapGenerator.ZoneData zone)
    {
        if (currentZoneText != null)
        {
            currentZoneText.text = $"📍 {zone.zoneName}";
        }

        if (zoneInfoText != null)
        {
            var district = GetDistrictData(zone.zoneType);
            if (district != null)
            {
                string services = string.Join(", ", district.availableServices);
                zoneInfoText.text = $"{district.description}\n\nServices: {services}";
            }
        }
    }

    private DistrictData GetDistrictData(MapGenerator.ZoneType type)
    {
        var districts = DistrictData.GetDefaultDistricts();
        foreach (var district in districts)
        {
            if (district.zoneType == type)
                return district;
        }
        return null;
    }

    private void OnDestroy()
    {
        var zoneManager = ZoneManager.Instance;
        if (zoneManager != null)
        {
            zoneManager.OnEnterZone -= UpdateZoneDisplay;
        }
    }
}
