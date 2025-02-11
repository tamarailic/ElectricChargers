﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Charger")]
    public class Charger
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [Column("serialNumber")]
        [JsonPropertyName("serialNumber")]
        public int SerialNumber { get; set; }

        [Column("chargingSpeed")]
        [JsonPropertyName("chargingSpeed")]
        public decimal ChargingSpeed { get; set; }

        [Column("isBusy")]
        [JsonPropertyName("isBusy")]
        public bool IsBusy { get; set; }

        [Column("isWorking")]
        [JsonPropertyName("isWorking")]
        public bool IsWorking { get; set; }

        [Column("station")]
        [JsonPropertyName("station")]
        public Guid StationId { get; set; }

        [JsonPropertyName("fullStation")]
        public Station Station { get; set; }

        [Column("rfid")]
        [JsonPropertyName("rfid")]
        public string Rfid { get; set; }

    }
}
