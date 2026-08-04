var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();
var incidents = new List<Incident>
{
    new(1, "Email service unavailable", "High", "Open", "ServiceNow"),
    new(2, "VPN access failure", "Medium", "In Progress", "Jira"),
    new(3, "Suspicious login detected", "Critical", "Resolved", "ServiceNow")
};

app.MapGet("/", () => Results.Ok(new
{
    service = "Enterprise IT Operations API",
    status = "Running"
}));

app.MapGet("/health", () => Results.Ok(new
{
    status = "Healthy",
    service = "Enterprise IT Operations API",
    timestamp = DateTime.UtcNow
}));

app.MapGet("/incidents", () => Results.Ok(incidents));

app.MapGet("/incidents/{id:int}", (int id) =>
{
    var incident = incidents.FirstOrDefault(x => x.Id == id);

    return incident is null
        ? Results.NotFound(new { message = $"Incident {id} was not found." })
        : Results.Ok(incident);
});

app.MapPost("/incidents", (CreateIncidentRequest request) =>
{
    var incident = new Incident(
        incidents.Max(x => x.Id) + 1,
        request.Title,
        request.Priority,
        "Open",
        request.Source
    );

    incidents.Add(incident);

    return Results.Created($"/incidents/{incident.Id}", incident);
});

app.Run();

record Incident(
    int Id,
    string Title,
    string Priority,
    string Status,
    string Source
);

record CreateIncidentRequest(
    string Title,
    string Priority,
    string Source
);