using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetGlade.Onboarding.DummyDevice.Authentication;
using NetGlade.Onboarding.DummyDevice.Models;
using NetGlade.Onboarding.DummyDevice.Services.Abstractions;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace NetGlade.Onboarding.DummyDevice.Areas.Telemetries;

public class PdfHandler : IHandler
{
    private readonly ApplicationDbContext _context;

    public PdfHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<MemoryStream> GeneratePdfStream()
    {
        var stream = new MemoryStream();
        var data = await GetAverageDataAsync();

        var unixTimeNow = new DateTimeOffset(DateTime.UtcNow);
        var unixTimeMinusMonth = new DateTimeOffset(DateTime.UtcNow.AddMonths(-1));
        var amountOfErrors = await _context.TelemetryErrors.Where(x => unixTimeNow.ToUnixTimeSeconds() >= x.Timestamp && x.Timestamp >= unixTimeMinusMonth.ToUnixTimeSeconds()).CountAsync();

        Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(2, Unit.Centimetre);
                page.DefaultTextStyle(x => x.FontSize(20));
                page.Header().Element(ComposeHeader);

                page.Content().Column(y =>
                    {
                        y.Item().LineHorizontal(1).LineColor(Colors.Black);
                        y.Item().Background(Colors.Transparent).Unconstrained().AlignCenter().AlignMiddle().PaddingLeft(4, Unit.Centimetre).Rotate(45).Text("Netglade").FontFamily(Fonts.Impact).FontSize(160).FontColor(Colors.Grey.Lighten4);
                        y.Item().PaddingVertical(2, Unit.Centimetre).PaddingLeft(1, Unit.Centimetre).Column(x =>
                        {
                            x.Spacing(30);
                            x.Item().Text(text =>
                            {
                                text.Span("Average altitude: ").SemiBold();
                                text.Span($"{data.Altitude} mm");
                            });
                            x.Item().Text(text =>
                            {
                                text.Span("Average radiation: ").SemiBold();
                                text.Span($"{data.Radiation} mSv");
                            });
                            x.Item().Text(text =>
                            {
                                text.Span("Average velocity: ").SemiBold();
                                text.Span($"{data.Velocity} m/s");
                            });
                            x.Item().Text(text =>
                            {
                                text.Span("Average temperature: ").SemiBold();
                                text.Span($"{data.Temperature} °C");
                            });
                            x.Item().Text(text =>
                            {
                                text.Span("Amount of errors: ").SemiBold();
                                text.Span(amountOfErrors.ToString());
                            });
                        });
                    });
            });
        }).GeneratePdf(stream);

        stream.Seek(0, SeekOrigin.Begin);
        return stream;
    }

    private async Task<SatelliteTelemetry> GetAverageDataAsync()
    {
        var unixTimeNow = new DateTimeOffset(DateTime.UtcNow);
        var unixTimeMinusMonth = new DateTimeOffset(DateTime.UtcNow.AddMonths(-1));

        var data = _context.SatelliteTelemetries.OrderByDescending(x => x.Timestamp).Where(x => unixTimeNow.ToUnixTimeSeconds() >= x.Timestamp && x.Timestamp >= unixTimeMinusMonth.ToUnixTimeSeconds());
        var averageData = new SatelliteTelemetry
        {
            Altitude = (long)(await data.AverageAsync(x => x.Altitude)),
            Temperature = (int)(await data.AverageAsync(x => x.Temperature)),
            Velocity = (int)(await data.AverageAsync(x => x.Velocity)),
            Radiation = (int)(await data.AverageAsync(x => x.Radiation))
        };

        return averageData;
    }

    private void ComposeHeader(IContainer container)
    {
        var titleStyle = TextStyle.Default.FontSize(20).SemiBold().FontColor(Colors.Black);

        container.Row(row =>
        {
            row.RelativeItem().Column(column =>
            {
                column.Item().Text("Monthly Report").Style(titleStyle);

                column.Item().Text(text =>
                {
                    text.Span("Issue date: ").SemiBold();
                    text.Span($"{DateTime.Today.ToString("d")}");
                });

                column.Item().Text(text =>
                {
                    text.Span("For period: ").SemiBold();
                    text.Span($"{DateTime.Today.ToString("d")} - {DateTime.Today.AddMonths(-1).ToString("d")}");
                });
            });
        });
    }

}
